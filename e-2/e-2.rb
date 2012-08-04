str = []
puts "\n\t********Enter code to run. After that press enter to see the output********\n\n"
loop do  
  str << gets
  case str[str.size - 1].gsub(/[\s]/i, "")
  when ""
      puts eval str.join
      str = []
  when "q"
    puts "****Thank you for using it****"
    break;
  end
end
