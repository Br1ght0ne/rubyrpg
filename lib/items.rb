class Inventory
  def initialize
    @items = [SmallHealthPotion.new]
  end
  attr_accessor :items
end

class Equipment
  def initialize
    weapon_init
    armor_init
    jewelry_init
  end

  attr_accessor :weapon,
                :helmet, :armor, :gloves, :cape, :boots, :leggings,
                :ring_left, :ring_right, :amulet, :belt

  private

  def weapon_init
    @weapon = Weapon.new('Handmade Dagger', 2)
  end

  def armor_init
    @helmet = Helmet.new('no helmet', 0)
    @armor = Armor.new('no armor', 0)
    @gloves = Gloves.new('no gloves', 0)
    @cape = Cape.new('no cape', 0)
    @boots = Boots.new('no boots', 0)
    @leggings = Leggings.new('no leggings', 0)
  end

  def jewelry_init
    @ring_left = RingLeft.new('no ring on left hand', '*nothing*', 0)
    @ring_right = RingRight.new('no ring on right hand', '*nothing*', 0)
    @amulet = Amulet.new('no amulet', '*nothing*', 0)
    @belt = Belt.new('no belt', '*nothing*', 0)
  end

  public

  def list
    items = [@weapon, @helmet, @armor, @gloves, @cape, @boots,
             @leggings, @ring_left, @ring_right,
             @amulet, @belt]
    items.each do |item|
      puts "\n#{item.type}: #{item.name} - increases #{item.increase_type} "\
           "by #{item.increase_value}"
    end
  end
end

class Weapon
  def initialize(name, dmg_increase)
    @type = 'Weapon'
    @increase_type = 'damage'
    @name = name
    @increase_value = dmg_increase
    @dmg_increase = dmg_increase
  end
  attr_reader :name, :type, :increase_type, :increase_value
  attr_accessor :dmg_increase
end

class Clothing
  def initialize(def_increase)
    @increase_type = 'defense'
    @increase_value = def_increase
  end
  attr_reader :increase_type, :name, :increase_value
end

class Helmet < Clothing
  def initialize(name, def_increase)
    @name = name
    @type = 'Helmet'
    super(def_increase)
  end
  attr_reader :type
end

class Armor < Clothing
  def initialize(name, def_increase)
    @name = name
    @type = 'Armor'
    super(def_increase)
  end
  attr_reader :type
end

class Gloves < Clothing
  def initialize(name, def_increase)
    @name = name
    @type = 'Gloves'
    super(def_increase)
  end
  attr_reader :type
end

class Cape < Clothing
  def initialize(name, def_increase)
    @name = name
    @type = 'Cape'
    super(def_increase)
  end
  attr_reader :type
end

class Boots < Clothing
  def initialize(name, def_increase)
    @name = name
    @type = 'Boots'
    super(def_increase)
  end
  attr_reader :type
end

class Leggings < Clothing
  def initialize(name, def_increase)
    @name = name
    @type = 'Leggings'
    super(def_increase)
  end
  attr_reader :type
end

class Jewelry
  def initialize(increase_type, increase_value)
    @increase_type = increase_type
    @increase_value = increase_value
  end
  attr_reader :name, :increase_type, :type, :increase_value
end

class RingLeft < Jewelry
  def initialize(name, increase_type, increase_value)
    @name = name
    @type = 'Ring (left hand)'
    super(increase_type, increase_value)
  end
  attr_reader :type
end

class RingRight < Jewelry
  def initialize(name, increase_type, increase_value)
    @name = name
    @type = 'Ring (right hand)'
    super(increase_type, increase_value)
  end
  attr_reader :type
end

class Amulet < Jewelry
  def initialize(name, increase_type, increase_value)
    @name = name
    @type = 'Amulet'
    super(increase_type, increase_value)
  end
  attr_reader :type
end

class Belt < Jewelry
  def initialize(name, increase_type, increase_value)
    @name = name
    @type = 'Belt'
    super(increase_type, increase_value)
  end
  attr_reader :type
end

class Potion
end

class HealthPotion < Potion
  def initialize
    @usage = "type #{@code} to use"
    @is_consumable = true
    @desc = "restores your HP by #{@hp_restore}"
  end

  def use
    raise if $player.hp == $player.max_hp
    healed = heal
    puts "Restored #{healed} HP."
  rescue
    puts "You can\'t use health potions while you have full HP."
    sleep(1.5)
    $player.inspect_items
  end

  def heal
    hp_before_heal = $player.hp
    $player.hp += @hp_restore
    $player.hp = $player.max_hp if $player.hp > $player.max_hp
    healed = $player.hp - hp_before_heal
    healed
  end
end

class SmallHealthPotion < HealthPotion
  def initialize
    @code = 'SHP'
    @name = 'Small Health Potion'
    @hp_restore = 20
    super
  end
  attr_reader :name, :code, :hp_restore, :desc, :is_consumable, :usage
end

class DroppedItems
end

class Junk < DroppedItems
  def initialize
    @usage = 'junk, no use'
    @is_consumable = true
    @desc = 'should be sold in shop'
  end

  attr_reader :usage, :is_consumable, :desc
end

class StainedSheet < Junk
  def initialize
    super
    @name = 'Stained Sheet'
    @type = 'Junk'
    @value = 3
  end

  attr_reader :name, :type, :value
end

class GhoulSkin < Junk
  def initialize
    super
    @name = 'Ghoul Skin'
    @type = 'Junk'
    @value = 5
  end

  attr_reader :name, :type, :value
end

class DragonEye < Junk
  def initialize
    super
    @name = 'Dragon Eye'
    @type = 'Junk'
    @value = 30
  end

  attr_reader :name, :type, :value
end

class VampireTeeth < Junk
  def initialize
    super
    @name = 'Vampire Teeth'
    @type = 'Junk'
    @value = 12
  end

  attr_reader :name, :type, :value
end

class Ring < Jewelry
end
