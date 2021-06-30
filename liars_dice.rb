# LIARS DICE
# By Chris Gibson

#declarations
#arrays
tally_results = Array.new(6, 0)
turn_order = Array.new
#variables
number = 1
index = 0
number_of_dice = 0
die_result = 0
current_product = 0

# Player class
class Player
	def initialize(name, number)
		@name = name
		@turn_number = number
		@dice_results = Array.new
	end
    def name
        @name
    end
    def turn_number
		@turn_number
	end
	def die_cast
		while @dice_results.length < 5
        	r = rand(1..6)
			@dice_results << r
		end
	end
	def dice_results
		@dice_results
	end
end

#begins program
puts "Welcome to Liars Dice!"
puts "Please enter the number of players. (Between 2 and 4)"
total_players = gets.to_i
while total_players < 2 || total_players > 4
	puts "Number of players must be between 2 and 4, try again"
	total_players = gets.to_i
end

#creates class instances based on total_players
while number < (total_players + 1)
	puts "What is the name of Player #{number}?"
	get_name = gets.chomp
	player = Player.new(get_name, number)
	player.die_cast
	player.dice_results.each {|element| tally_results[element - 1] += 1}
	turn_order << player
	number += 1
end

#rules of the game
system "clear"
puts "Here are the rules:
Everyone gets 5 dice.
You can either make a bet or call someone a liar.
To make a bet you input the number of dice, then the value of those dice.
You base your bet on all dice in the game (Including other players).
You can call out the last player for being a liar if you think their bet is a lie.
The first player that is a liar loses the game.
You are a liar if you are caught with a liars bet, or falsely accuse another of making a liars bet.
Good luck...
Press any key to start."
continue = gets.chomp

#game loop
while index <= total_players
	#this if resets the loop to the first player once it reaches the last player
	if index == total_players
		index = 0
	end
	#player info display
	current_player = turn_order[index]
	system "clear"
	puts "The dice are cast, #{current_player.name}. Place your bet, or call someone a liar."
	puts "Current bet: Number of Dice: #{number_of_dice}, Die Side: #{die_result}"
	puts "Your dice: #{current_player.dice_results.join(', ')}"
	puts "Enter a number to choose an option.
	1. Place your Bet
	2. Call the last player a liar
	3. End game"
	
	#loop for options
	next_player = false
	while next_player == false
	#options
		option = gets.to_i
		case option
		when 1 #Up the Bet
			product_is_higher = false
			while product_is_higher == false
				puts "Number of Dice you wish to bet?"
				number_of_dice = gets.to_i
				puts "And the Die Side?"
				die_result = gets.to_i
				product = number_of_dice * die_result
				if product > current_product
					current_product = product
					product_is_higher = true
				else
					puts "That's not good enough! Make a bigger bet!"
					next
				end
			end
			previous_player = current_player
			index += 1
			next_player = true
		when 2 #Call the last player a Liar
			if number_of_dice > tally_results[die_result - 1]
				puts "#{previous_player.name}, you're a liar and will spend eternity aboard this ship!"
				sleep 3
				puts "#{previous_player.name} loses the game!"
				exit
			else
				puts "#{current_player.name}, you're the liar! Part of the crew, part of the ship!"
				sleep 3
				puts "#{current_player.name} loses the game!"
				exit
			end
		when 3 #End the game
			puts "Thanks for playing!"
			exit
		else
			puts "Please enter 1, 2, or 3."
		end
	end
	#Clears previous player and starts timer to new player
	system "clear"
	puts "Next player in..."
	[3,2,1].each {|n| puts "#{n}.."; sleep 1}
end

=begin
NOTES:

High Priority:
class Player COMPLETE
player object creation COMPLETE
tally_results COMPLETE
display options/dice to current player COMPLETE
turn_order loop, P0..PN, then repeat loop COMPLETE
up_bet COMPLETE
challenge COMPLETE
end game option COMPLETE

Low Priority:
checks/balances: check user input is correct COMPLETE
user input specific names for each player COMPLETE
Add a way to clear previous player 'puts' COMPLETE
Add delay between players so other players have time to look away COMPLETE
Added rules of the game COMPLETE
=end
