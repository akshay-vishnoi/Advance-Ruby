class DerivedString < String
  def exclude?(pattern)
    puts self.match(pattern) ? true : false
  end
  def palindrome?
    puts  self == self.reverse ? true : false
  end
  def character_occurence
    occurences = Hash.new(0)
    self.each_char do |answer_alpha|
      occurences[answer_alpha.to_sym] += 1 if answer_alpha != " "
    end
    occurences.each do |key, value|
      puts "#{key}'s count is #{value}"
    end
  end
end

print "Create an object of String like 'DerivedString.new('<string>')' : "
object_name = gets.chomp
derived_string = instance_eval object_name
print "New String is created with value: #{derived_string}\n" 

puts "Call a Method('exclude?(pattern)', 'palindrome?', 'character_occurence'): "
instance_eval "derived_string." + gets.chomp
