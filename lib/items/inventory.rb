require_relative('health_potions')

class Inventory
  attr_accessor :items

  def initialize
    @items = [SmallHealthPotion.new]
  end

  def new_item(item)
    @items.push(item)
  end
end
