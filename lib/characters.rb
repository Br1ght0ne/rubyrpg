require_relative 'zones'
require_relative 'modules'
require_relative 'items'

# Class for handling player state and interactions with world/self
class Player
  include LoadAndSave

  def initialize(name)
    @name = name.capitalize
    fetch_items
    fetch_char
    fetch_state
    @item_fields = [@weapon, @helmet, @armor,
                    @gloves, @cape, @boots,
                    @leggings, @ring_left, @ring_right,
                    @amulet, @belt]
  end

  private

  def fetch_state
    $current_zone = StartZone.new
    @location = $current_zone.name
  end

  def fetch_skills
    @skills = []
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def fetch_items
    @items = [SmallHealthPotion.new]
    @weapon = Weapon.new('Handmade Dagger', 2)
    @helmet = Helmet.new('no helmet', 0)
    @armor = Armor.new('no armor', 0)
    @gloves = Gloves.new('no gloves', 0)
    @cape = Cape.new('no cape', 0)
    @boots = Boots.new('no boots', 0)
    @leggings = Leggings.new('no leggings', 0)
    @ring_left = RingLeft.new('no ring on left hand', '*nothing*', 0)
    @ring_right = RingRight.new('no ring on right hand', '*nothing*', 0)
    @amulet = Amulet.new('no amulet', '*nothing*', 0)
    @belt = Belt.new('no belt', '*nothing*', 0)
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  def fetch_char
    fetch_hp
    fetch_def
    fetch_dmg
    fetch_evasion
    fetch_accuracy
    fetch_exp
  end

  def fetch_hp
    @max_hp = 100
    @hp = @max_hp
  end

  def fetch_def
    @base_def_min = 0
    @base_def_max = 4
    @armor_value = @helmet.increase_value + @armor.increase_value +
                   @gloves.increase_value + @boots.increase_value +
                   @leggings.increase_value
    @def_min = @base_def_min + @armor_value
    @def_max = @base_def_max + @armor_value
  end

  def fetch_dmg
    @base_dmg_min = 3
    @base_dmg_max = 8
    @dmg_min = @base_dmg_min + @weapon.dmg_increase
    @dmg_max = @base_dmg_max + @weapon.dmg_increase
  end

  def fetch_evasion
    @evasion = 20
    @evade_chance = rand(1..@evasion)
  end

  def fetch_accuracy
    @accuracy = 70
    @hit_chance = rand(1..@accuracy)
  end

  # rubocop:disable Style/CaseEquality
  def fetch_exp
    @exp = 0
    @lvl = $exp_levels.select { |exp| exp === @exp }.values.first
    @next_lvl = @lvl + 1
    @next_level_exp = $exp_levels.key(@next_lvl).begin.to_i
    @to_next_level = @next_level_exp - @exp
  end
  # rubocop:enable Style/CaseEquality

  public

  def display_player_info
    puts "\nDisplaying info for #{$player.class}: #{$player.name}..."
    sleep(1)
    puts "\nName: #{@name}\nLevel: #{@lvl} "\
         "(#{@to_next_level} to next level)\n"\
         "HP: #{@hp}/#{@max_hp}\nDamage: #{@dmg_min}-#{@dmg_max} "\
         "(including #{@weapon.dmg_increase} from #{@weapon.name})\n"\
         "Defense: #{@def_min}-#{@def_max} (including #{@armor_value} "\
         "from equipped items)\nEvasion: #{@evasion}\nAccuracy: #{@accuracy}"
  end

  def inspect_items
    puts "\nInspecting items of #{$player.class}: #{$player.name}..."
    sleep(1)
    $player.item_fields.each do |item|
      puts "\n#{item.type}: #{item.name} - increases #{item.increase_type} "\
           "by #{item.increase_value}"
    end
    # puts "\nWeapon:\n#{@weapon.name} - increases damage dealt by "\
    #      "#{@weapon.dmg_increase}"
    # puts "\nHelmet:\n#{@helmet.name} - increases defense by "\
    #      "#{@helmet.def_increase}"
    # puts "\nArmor:\n#{@armor.name} - increases defense by "\
    #      "#{@armor.def_increase}"
    # puts "\nGloves:\n#{@gloves.name} - increases defense by "\
    #      "#{@gloves.def_increase}"
    # puts "\nCape:\n#{@cape.name} - increases dexterity by "\
    #      "#{@cape.dex_increase}"
    # puts "\nBoots:\n#{@boots.name} - increases defense by "\
    #      "#{@boots.def_increase}"
    # puts "\nLeggings:\n#{@leggings.name} - increases defense by "\
    #      "#{@leggings.def_increase}"
    # puts "\nRing (left hand):\n#{@ring_left.name} - increases "\
    #      "#{@ring_left.increase_type} by #{@ring_left.increase_value}"
    # puts "\nRing (right hand):\n#{@ring_right.name} - increases "\
    #      "#{@ring_right.increase_type} by #{@ring_right.increase_value}"
    # puts "\nAmulet:\n#{@amulet.name} - increases #{@amulet.increase_type} "\
    #      "by #{@amulet.increase_value}"
    # puts "\nBelt:\n#{@belt.name} - increases #{@belt.increase_type} by "\
    #      "#{@belt.increase_value}"
    puts "\nItems:"
    item_show_loop
  end

  private

  def item_show_loop
    i = 0
    loop do
      if $player.items[i].class == NilClass
        i = 0
        break
      end # if
      puts "#{$player.items[i].name} (#{$player.items[i].usage}) - #{$player.items[i].desc}"
      i += 1
    end # loop
    begin
      puts "\nType the code of the item you want to use (or 'exit' to quit items)"
      userCode = gets.chomp
      if userCode == 'exit'
        check_for_fight
      else
        i = 0
        loop do
          if $player.items[i].code == userCode
            $player.items[i].use
            $player.items.delete_at(i) if $player.items[i].isConsumable
            check_for_fight
          end # if
          i += 1
        end # loop
      end # if
    rescue NoMethodError
      puts 'Please enter valid item code.'
      sleep(1.5)
      retry
    end # begin
  end # item_show_loop
  # rubocop:enable MethodLength

  public

  def inspect_skills
    puts 'Not implemented yet.'
    check_for_fight
  end
  # rubocop:enable NestedMethodDefinition

  def move
    puts "\nYour current location: #{@location}"
    sleep(1.5)
    $moveZones = Array[]
    4.times { |_i| $moveZones.push(ZoneGenerator.new.generated_zone) }
    puts "\nZones you can travel to:"
    $moveZones.each do |zone|
      index = $moveZones.index(zone)
      name = zone.name
      puts "#{name} - #{index}"
    end
    user_zone = gets.chomp
    user_zone = $moveZones[user_zone.to_i]
    puts "\nYour character wanders along... Until he sees #{user_zone.desc}."
    $current_zone = user_zone
    @location = $current_zone.name
    $current_zone.check_for_enemy(user_zone.enemy_name)
  end

  def attack_enemy
    dmg = rand(@dmg_min..@dmg_max)
    $enemy.hp -= dmg
    $enemy.hp = 0 if $enemy.hp <= 0
    puts "\nDealt #{dmg} DMG to #{$enemy.name} (#{$enemy.hp} left)"
    sleep(1.5)
    if $enemy.hp.zero? # defeated enemy
      puts "\nYou defeated #{$enemy.name}!"
      @old_lvl = @lvl
      @exp += $enemy.exp
      @lvl = $exp_levels.select { |exp| exp === @exp }.values.first
      @next_lvl = @lvl + 1; @next_level_exp = $exp_levels.key(@next_lvl).begin
      @to_next_level = @next_level_exp - @exp
      sleep(1.5)
      puts "\nGained #{$enemy.exp} experience (#{@to_next_level} to next level).\n"
      check_for_level_change
      $enemy.send(:drop)
      $enemy = nil; $isFight = false
    else
      $enemy.send(:attack_player)
    end
  end

  def check_for_level_change
    puts "\nLevel gained!\nYour level is now #{@lvl}." if @lvl > @old_lvl
  end

  attr_reader :name, :item_fields
  attr_accessor :lvl, :exp
  attr_accessor :location
  attr_accessor :hp, :max_hp
  attr_accessor :dmg_min, :dmg_max, :dmg
  attr_accessor :evasion
  attr_accessor :accuracy
  attr_accessor :skills
  attr_accessor :items
end

# generic enemy class to import modules
class Enemy
  include Action
  include Drop

  public

  def spawn
    puts "\nA fearsome #{@name} stands on your way! Engaging in fight..."
    $isFight = true
    sleep(1.5)
    puts "\nYour HP: #{$player.hp} | #{@name}\'s HP: #{@hp}"
    get_fight_action
  end

  def attack_player
    dmg = rand(@dmg_min..@dmg_max)
    $player.hp -= dmg
    puts "\n#{@name} deals #{dmg} DMG to #{$player.name}!"
    sleep(1.5)
    puts "\nYour HP: #{$player.hp} | #{@name}\'s HP: #{@hp}"
    sleep(1.5)
    if $player.hp > 0
      get_fight_action
    else
      $player = nil
      puts "You were killed by #{@name}.\n"
      check_for_restart
    end
  end
  attr_reader :exp
end

class Ghost < Enemy
  def initialize
    @name = 'Ghost'
    @max_hp = rand(5..15); @hp = @max_hp
    @exp = rand(4..8)
    @dmg_min = 2; @dmg_max = 5
    @evasion = 60; @evade_chance = rand(1..@evasion)
    @accuracy = 30; @hit_chance = rand(1..@accuracy)
    @skills = ['Crippling Fear']
    @item_drop = [StainedSheet.new]
  end
  attr_reader :name, :skills, :appear_chance, :item_drop
  attr_accessor :lvl, :hp, :dmg_min, :dmg_max, :dmg, :evasion, :accuracy
end

class Ghoul < Enemy
  def initialize
    @name = 'Ghoul'
    @max_hp = rand(9..11); @hp = @max_hp
    @exp = rand(6..10)
    @dmg_min = 7; @dmg_max = 11; @dmg = rand(@dmg_min..@dmg_max)
    @evasion = 15; @evade_chance = rand(1..@evasion)
    @accuracy = 65; @hit_chance = rand(1..@accuracy)
    @skills = []
    @item_drop = [GhoulSkin.new]
  end
  attr_reader :name, :skills, :appear_chance, :item_drop
  attr_accessor :lvl, :hp, :dmg_min, :dmg_max, :dmg, :evasion, :accuracy
end

class Dragon < Enemy
  def initialize
    @name = 'Dragon'
    @max_hp = rand(15..24)
    @hp = @max_hp
    @exp = rand(11..16)
    @dmg_min = 12
    @dmg_max = 15
    @dmg = rand(@dmg_min..@dmg_max)
    @evasion = 10
    @evade_chance = rand(1..@evasion)
    @accuracy = 40
    @hit_chance = rand(1..@accuracy)
    @skills = ['Breathe Fire']
    @item_drop = [DragonEye.new]
  end
  attr_reader :name, :skills, :appear_chance, :item_drop
  attr_accessor :lvl, :hp, :dmg_min, :dmg_max, :dmg, :evasion, :accuracy
end

class Vampire < Enemy
  def initialize
    @name = 'Vampire'
    @max_hp = rand(8..14); @hp = @max_hp
    @exp = rand(9..13)
    @dmg_min = 8; @dmg_max = 12; @dmg = rand(@dmg_min..@dmg_max)
    @evasion = 30; @evade_chance = rand(1..@evasion)
    @accuracy = 80; @hit_chance = rand(1..@accuracy)
    @skills = ['Ritual of Blood Moon', 'Invisibility']
    @item_drop = [VampireTeeth.new]
  end
  attr_reader :name, :skills, :appear_chance, :item_drop
  attr_accessor :lvl, :hp, :dmg_min, :dmg_max, :dmg, :evasion, :accuracy
end
