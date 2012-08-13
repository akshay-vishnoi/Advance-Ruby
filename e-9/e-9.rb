module MyModule
  def self.included(klass)
    klass.class_eval do
      def klass.chained_aliasing(*args)
        pub = self.new.public_methods - Object.public_methods
        protect = self.new.protected_methods - Object.protected_methods
        priv = self.new.private_methods - Object.private_methods
        args.each do |func|
          if(pub.include? func)
            mode = :public
          elsif(priv.include? func)
            mode = :private
          else
            mode = :protected
          end
          func_name = func.to_s
          extension = ""
          if(func_name[-1,1] == '!')
            extension = "!"
            func_name.chop!
          elsif(func_name[-1,1] == '?')
            extension = '?'
            func_name.chop!
          end
          meth_with = func_name + "_with_logger"+ extension
          meth_without = func_name + "_without_logger" + extension
          alias_method meth_without, func
          define_method(meth_with) do 
            puts "--logger start"
            instance_eval(meth_without)
            puts "--logger end"
          end
          self.send mode, meth_with
          alias_method func, meth_with
        end
      end
    end
  end
end

class Hello
  include MyModule  
  def greet
    puts "Hello"
  end
  protected
  def put?
    puts "put"
  end
  private
  def ring?
    puts "ring"
  end
  chained_aliasing :put?, :greet, :ring?
end

#main
say = Hello.new
puts "\nWith logger:"
say.greet_with_logger
puts "\nSimple:"
say.greet
puts "\nWithout logger:"
say.greet_without_logger

#All methods Public, Private and Protected
puts "\n\n********************\n\n"
puts "Public methods:\n"
puts Hello.new.public_methods - Object.public_methods
puts "\n\n********************\n\n"
puts "Private methods:\n"
puts Hello.new.private_methods - Object.private_methods
puts "\n\n********************\n\n"
puts "Protected methods:\n"
puts Hello.new.protected_methods - Object.protected_methods
puts "\n\n********************\n\n"
