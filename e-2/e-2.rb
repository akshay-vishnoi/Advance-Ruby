str = []
puts "\n\tEnter code to run. After that press enter 2 times to see the output\n\n"
loop do  
  str << gets
  if (str[str.size-1] === "\n" && str[str.size - 2] === "\n")
    puts eval str.join
    break;
  end
end
  
