#main
puts "\nEnter name of the function"
func_name = gets.chomp
puts "\nEnter 1-line statement for function"
func_statement = gets.chomp
puts "\nCalling method: #{func_name}()\n"
    self.class_eval do
define_method(func_name) do
        eval(func_statement)
end

end

eval "func_name"
