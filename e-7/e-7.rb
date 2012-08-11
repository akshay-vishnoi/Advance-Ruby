#Fetching File name.
print "Enter the name of the csv file('movies.csv', 'employees.csv', 'players.csv'): "
file_name = gets.chomp

#Fetching lines in file, also stripping all whitespaces
lines = File.readlines(file_name)
lines_stripped = []
for i in 0..(lines.length - 1)
  temp = []
  lines[i].split(',').each do |val|
    temp << val.strip
  end
  lines_stripped[i] = temp
end

#Class creation with 2 methods.
class_name = file_name.split(".")[0].capitalize
class_const = Object.const_set(class_name, Class.new)
class_const.class_eval do
  define_method('initialize') do |values, name|
    instance_variable_set("@list", name)
    name.each_with_index do |name, i|
      instance_variable_set("@" + name, values[i])
    end
  end
  define_method('to_s') do |val|
    puts "#{self.class}(#{val}): " 
    @list.each_with_index do |val, i|
      puts "#{@list[i].capitalize} => #{instance_variable_get("@" + val)}"
    end
    puts
  end
end

#Main: Creating an array of objects and calling both methods.
puts "\n\nObjects of #{class_name} = #{lines_stripped.length - 1}:\n\n"
objects = []
for i in 1..(lines_stripped.length-1)
  objects[i - 1] = class_const.new(lines_stripped[i], lines_stripped[0])
  objects[i - 1].to_s(i)
end
