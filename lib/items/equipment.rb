require_relative('weapon')
require_relative('clothing')

class Equipment
  def initialize
    weapon_init
    armor_init
    jewelry_init
  end

  attr_accessor :weapon, :helmet, :armor, :gloves, :cape, :boots,
                :leggings, :ring_left, :ring_right, :amulet, :belt

  def list
    items = [@weapon, @helmet, @armor, @gloves, @cape, @boots,
             @leggings, @ring_left, @ring_right,
             @amulet, @belt]
    items.each do |item|
      puts "\n#{item.type}: #{item.name} - increases #{item.increase_type} "\
           "by #{item.increase_value}"
    end
  end

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

end