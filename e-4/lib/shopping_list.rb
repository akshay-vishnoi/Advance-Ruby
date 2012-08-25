class ShoppingList
  def initialize
    @item = {}
  end
  def items(&block)
    instance_eval &block
  end
  def add(name, quantity)
    @item[name] ||= 0
    @item[name] += quantity
  end
  def to_s
    item_array = []
    @item.each do |key, value|
      item_array << "#{key.ljust(20, '.')}#{value}"
    end
    item_array.join("\n");
  end
end
