def calculate first_operand, operator, second_operand
  puts [first_operand, second_operand].reduce(operator)
end


#main
puts "Add operation"
calculate 4, :+, 2
puts "Subtract operation"
calculate 4, :-, 2
puts "Multiply operation"
calculate 4, :*, 2
puts "Divide operation"
calculate 4, :/, 2
puts "Power operation"
calculate 4, :**, 2

