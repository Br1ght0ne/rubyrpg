class Item
  def initialize(order)
    @order = order
  end
  attr_reader :order
end

class Weapon < Item
  def initialize(name,dmg_increase)
    @name = name; @dmg_increase = dmg_increase
  end
  attr_reader :name; attr_accessor :dmg_increase
end

class Potion < Item
end

class HealthPotion < Potion

  def use
    begin
      raise if $player.hp == $player.max_hp
      $player.hp += @hp_restore
      $player.hp = $player.max_hp if $player.hp > $player.max_hp
      puts "Restored #{@hp_restore} HP."
    rescue
      puts "You can\'t use health potions while you have full HP."
      sleep(1.5)
      $player.inspect_items
    end
  end
end

class SmallHealthPotion < HealthPotion
  def initialize(order)
    @order = order
    @isConsumable = true
    @name = "Small Health Potion"
    @hp_restore = 20; @desc = "restores your HP by #{@hp_restore}"
  end
  attr_reader :name, :code, :hp_restore, :desc, :isConsumable
end
