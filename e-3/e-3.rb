#main
puts "\nEnter name of the function"
func_name = gets.chomp
puts "\nEnter 1-line statement for function"
func_statement = gets.chomp
instance_eval "def #{func_name}
  #{func_statement}
end"
puts "\nCalling method: #{func_name}()\n"
instance_eval func_name
