def operation (num1, num2, operator)
    p num1
    p num2
    p operator
    puts eval("#{num1} #{operator} #{num2}")
end
a = ["+","-","*","/","%"]
a.each {|operator| operation(rand(0..10), rand(0..10), operator)}