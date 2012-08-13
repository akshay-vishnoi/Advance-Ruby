#module definition
module Filters
  def self.included(klass)
    klass.instance_eval do
      @@args_before = []
      def klass.before_filter(*args)
        class_meths = self.instance_methods - Object.instance_methods
        class_meths, args = simplify(class_meths, args)
        @@args_before = args 
        class_meths -= args
        class_meths.each do |func_name|
          m = instance_method(func_name)
          define_method(func_name) do |*arguments, &block|
            args.each do |filterd_func|
              self.send filterd_func.to_s unless filterd_func.to_s == func_name.to_s
            end
            m.bind(self).(*arguments, &block)            
          end
        end
      end
      def klass.after_filter(*args)
        class_meths_after = self.instance_methods - Object.instance_methods
        class_meths, args = simplify(class_meths, args)
        class_meths_after -= args
        class_meths_after -= @@args_before
        class_meths_after.each do |func_name|
          m = instance_method(func_name)
          define_method(func_name) do |*arguments, &block|
            m.bind(self).(*arguments, &block)
            args.each do |filterd_func|
              self.send filterd_func.to_s unless filterd_func.to_s == func_name.to_s
            end
          end
        end
      end
      def simplify(class_meths, args)
        if args.last.class.to_s == "Hash"
          if args.last.keys[0] == "only".to_sym
            class_meths = args.last.values[0]
          else
            class_meths -= args.last.values[0]
          end
          args.slice!(args.length - 1)
        end
        return class_meths, args      
      end
    end
  end
end

#class definition
class Sample
  include Filters
  def foo
    puts "in foo"
  end
  def bar
    puts "in bar"
  end
  def test_method
    puts "in test_method"
  end
  def main_function
    puts "in main_function"
  end
  before_filter :foo, :bar, :only => [:main_function]
  after_filter :test_method, :only => [:main_function]
end

#main
s = Sample.new
s.main_function

