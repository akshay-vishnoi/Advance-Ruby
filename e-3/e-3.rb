class FunctionCreate
  def memoize(method, func_stat)
    self.class.class_eval do
      return define_method(method) do
        eval(func_stat)
      end
    end
  end
end
#main
puts "\nEnter name of the function"
func_name = gets.chomp
puts "\nEnter 1-line statement for function"
func_statement = gets.chomp
puts "\nCalling method: #{func_name}()\n"
obj = FunctionCreate.new
func_call = obj.memoize(func_name, func_statement)
func_call.call
