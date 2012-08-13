module MyObjectStore
  def self.included(klass)
    klass.class_eval do
      attr_accessor :save_hash, :read
      @@save_hash = []
      @@validate_list = []
      define_method('save') do
        if ((validate_presence_of == true) && ((defined?(validate) == nil) || (instance_eval('validate') == true)))
            @@save_hash << self
        else
          puts "you havent validate object"
        end
      end
      define_method('validate_presence_of') do
        flag = true
        @@validate_list.each do |val|
          if instance_eval(val.to_s).nil?
            flag = false
          end
        end
        flag
      end
    end
    self.class.instance_eval do
      define_method('validate_presence_of') do |*args|
        @@validate_list = args     
      end
      define_method('count') do
        puts @@save_hash
      end
      vari = klass.instance_variables
      vari.each do |var|
        var = var.slice(1, var.length)
        define_method('find_by_' + var) do |value|
          filtrd_object = []
          @@save_hash.each do |val|
            if val.instance_eval(var) === value
              filtrd_object << val
            end
          end
          puts filtrd_object
        end
      end
    end
  end
end

class A	
  attr_accessor :age, :fname, :email
  @age = nil
  @email = nil
  @fname = nil
  include MyObjectStore

  validate_presence_of :fname, :email
  def validate
    true
  end
end

a = A.new
a.fname = "hello"
a.email = "a.a.com"
a.age = 2
a.save


b = A.new
b.fname = "hello"
b.email = "a.a.co"

b.save
A.find_by_email("a.a.com")
