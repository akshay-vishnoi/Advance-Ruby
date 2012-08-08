def shopping
  shopping_list = {}
  binding
end

shop = shopping
begin
  puts "\nEnter name of the item"
  item = gets.chomp
  puts "\nEnter quantity of #{item}"
  quantity = gets.chomp
  if quantity =~ /^\d+$/
    eval "shopping_list['#{item}'] = #{quantity}", shop
  else
    puts "\nYou havent entered valid number for quantity"
  end
  print "Do you want to continue(Y/n): "
  ask = gets.chomp
end while ask =~ /y/i

puts "\nItems(with quantity) in the list are:\n\n"
eval 'shopping_list.each_key do |key|
        puts "#{key.ljust(20, \'.\')}#{shopping_list[key]}"
      end', shop

puts "\nThanx. Have a good day!!"

