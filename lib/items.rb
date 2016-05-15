class Item
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

  def use()
    $player.hp += @hp_restore
    puts "Restored #{@hp_restore} HP."
  end
end

class SmallHealthPotion < HealthPotion
  def initialize
    @name = "Small Health Potion"; @code = "SHP"
    @hp_restore = 20; @desc = "restores your HP by #{@hp_restore}"
  end
  attr_reader :name; attr_reader :code; attr_reader :hp_restore; attr_reader :desc
end
