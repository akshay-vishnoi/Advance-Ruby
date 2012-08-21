require_relative '../lib/shopping_list'

sl = ShoppingList.new
sl.item { |i| i.name("Toothpaste"); i.quantity(3) }
sl.item { |i| i.name("Computer"); i.quantity(1) }
sl.item { |i| i.name("Toothpaste"); i.quantity(3) }
sl.item { |i| i.name("Computer"); i.quantity(8) }
sl.item { |i| i.name("Pensil"); i.quantity(3) }
puts sl
