require_relative '../lib/shopping_list'

sl = ShoppingList.new
sl.items do
  add("Toothpaste",2)
  add("Computer",1)
end

sl.items do
  add("Shirts",2)
  add("Computer",1)
end

sl.items do
  add("Trousers",2)
  add("Computer",1)
end

#printing output
puts "\n\n"
puts "Your cart has items:".center(31, '*')
puts sl
puts "\n\n"
