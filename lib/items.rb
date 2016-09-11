class Item
end

class NoItem < Item
    def initialize(name)
        @name = name
    end
    attr_reader :name
end

class NoVarItem < NoItem
    def initialize(name)
        @name = name
        @increase_type = "*nothing*"
        @increase_value = 0
    end
    attr_reader :name, :increase_value, :increase_type
end

class NoDefenseItem < NoItem
    def initialize(name)
        @name = name
        @def_increase = 0
    end
    attr_reader :def_increase, :name
end

class NoDexterityItem < NoItem
    def initialize(name)
        @name = name
        @dex_increase = 0
    end
    attr_reader :dex_increase, :name
end

class Weapon < Item
  def initialize(name,dmg_increase)
    @name = name; @dmg_increase = dmg_increase
  end
  attr_reader :name; attr_accessor :dmg_increase
end

class Armor < Item
end

class Artifact < Item
end

class Jewelry < Artifact
end

class Potion < Item
end

class HealthPotion < Potion
    def initialize
        @usage = "type #{@code} to use"
        @isConsumable = true
        @desc = "restores your HP by #{@hp_restore}"
    end

    def use
        begin
          raise if $player.hp == $player.max_hp
          hp_before_heal = $player.hp
          $player.hp += @hp_restore
          $player.hp = $player.max_hp if $player.hp > $player.max_hp
          healed = $player.hp - hp_before_heal
          puts "Restored #{healed} HP."
        rescue
          puts "You can\'t use health potions while you have full HP."
          sleep(1.5)
          $player.inspect_items
        end
    end

end

class SmallHealthPotion < HealthPotion
<<<<<<< HEAD
    def initialize
        @code = "SHP"
        @name = "Small Health Potion"
        @hp_restore = 20
        super
    end
    attr_reader :name, :code, :hp_restore, :desc, :isConsumable, :usage
=======

  def initialize
    @code = "SHP"
    @usage = "type #{@code} to use"
    @isConsumable = true
    @name = "Small Health Potion"
    @hp_restore = 20; @desc = "restores your HP by #{@hp_restore}"
  end

  attr_reader :name, :code, :hp_restore, :desc, :isConsumable, :usage
>>>>>>> feature/artifacts
end

class DroppedItems
end

class Junk < DroppedItems

  def initialize
    @usage = "junk, no use"
    @isConsumable = true
    @desc = "should be sold in shop"
  end

  attr_reader :usage, :isConsumable, :desc
end

class StainedSheet < Junk

  def initialize
    super
    @name = "Stained Sheet"
    @type = "Junk"
    @value = 3
  end

  attr_reader :name, :type, :value
end

class GhoulSkin < Junk

  def initialize
    super
    @name = "Ghoul Skin"
    @type = "Junk"
    @value = 5
  end

  attr_reader :name, :type, :value
end

class DragonEye < Junk

  def initialize
    super
    @name = "Dragon Eye"
    @type = "Junk"
    @value = 30
  end

  attr_reader :name, :type, :value
end

class VampireTeeth < Junk

  def initialize
    super
    @name = "Vampire Teeth"
    @type = "Junk"
    @value = 12
  end

  attr_reader :name, :type, :value
end

class Ring > Jewelry

end
