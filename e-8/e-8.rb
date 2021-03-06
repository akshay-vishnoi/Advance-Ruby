module MyObjectStore
  def self.included(klass)
    @@vari = (klass.new.methods - Object.methods).to_a.uniq{ |val| val[/^\w+/]}
    klass.class_eval do
      attr_accessor :save_hash, :read
      @@save_objs = []
      @@validate_list = []
      define_method('save') do
        if ((validate_presence_of == true) && ((defined?(validate) == nil) || (instance_eval('validate') == true)))
            @@save_objs << self
            puts "#{self} has been validated and saved"
        else
          puts "Object doesnt pass validation"
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
    klass.instance_eval do
      class << self
        define_method('validate_presence_of') do |*args|
          @@validate_list = args     
        end
        define_method('count') do
          puts "Number of employees passing validation test are #{@@save_objs.length}"
        end
        define_method('collect') do
          puts "Employees those have been validated are #{@@save_objs}"
        end
        @@vari.each do |var|
          define_method('find_by_' + var.to_s) do |value|
            filtrd_object = []; rej_string = ""
            @@save_objs.each do |val|
              if val.instance_eval(var.to_s) === value
                filtrd_object << val
              end
              rej_string = "No Employee has #{var.capitalize} = #{value}"
            end
            puts filtrd_object.empty? ? rej_string : filtrd_object 
          end
        end
      end
    end
  end
end

class Employees	
  attr_accessor :id, :age, :fname, :email
  include MyObjectStore

  validate_presence_of :fname, :email, :id
  def validate
    true
  end
  def to_s
    "#{self.fname}(#{self.id})"
  end
end

#main
puts "\n**** Note: Employees will be shown with their ids like Dan(2)****"
puts "\nEmployee1 entered"
employee1 = Employees.new
employee1.id = 1
employee1.fname = "Dan"
employee1.email = "a.a.com"
employee1.age = 21
employee1.save

puts "\nEmployee2 entered"
employee2 = Employees.new
employee2.id = 2
employee2.fname = "Danny"
employee2.save

puts "\nEmployee3 entered"
employee3 = Employees.new
employee3.id = 3
employee3.fname = "Bill"
employee3.email = "a.a.co"
employee3.age = 41
employee3.save

puts "\nEmployee4 entered"
employee4 = Employees.new
employee4.id = 4
employee4.fname = "Dan"
employee4.email = "a.a.co"
employee4.save


puts "\nEmployee count"
Employees.count

puts "\nEmployee collect"
Employees.collect

puts "\nEmpoyee of age : 20" 
Employees.find_by_age(20)

puts "\nEmpoyee of email : a.a.com" 
Employees.find_by_email("a.a.co")

puts "\nEmpoyee of age : 41" 
Employees.find_by_age(41)

puts "\nEmpoyee of id : 4" 
Employees.find_by_id(4)

