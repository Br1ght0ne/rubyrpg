require_relative 'zones'
require_relative 'modules'
require_relative 'items'
module Exp
  def check_for_new_level

  end
end

class Character
  include Exp
  # include Fighting; include Movement; include Talking; include Skills
end

class Player < Character
include LoadAndSave
  def initialize(name)
    @name = name.capitalize
    @exp = 0; @lvl = $exp_levels.select {|exp| exp === @exp }.values.first
    @next_lvl = @lvl + 1; @next_level_exp = $exp_levels.key(@next_lvl).begin.to_i
    @to_next_level = @next_level_exp - @exp
    $current_zone = StartZone.new
    @location = $current_zone.name
    @max_hp = 100; @hp = @max_hp
    @base_dmg_min = 3; @base_dmg_max = 8
    @evasion = 20; @evade_chance = rand(1..@evasion)
    @accuracy = 70;  @hit_chance = rand(1..@accuracy)
    @skills = []
    @weapon = Weapon.new('Handmade Dagger',2)
    @helmet
    @armor
    @gloves
    @cape
    @boots
    @leggings
    @ring_left
    @ring_right
    @amulet
    @belt
    @dmg_min = @base_dmg_min + @weapon.dmg_increase; @dmg_max = @base_dmg_max + @weapon.dmg_increase
    @items = [SmallHealthPotion.new]
  end

  def display_player_info()
    puts "\nDisplaying info for #{$player.class}: #{$player.name}..."
    sleep(1)
    puts "\nName: #{@name}\nLevel: #{@lvl} (#{@to_next_level} to next level)\nHP: #{@hp}/#{@max_hp}\nDamage: #{@dmg_min}-#{@dmg_max} (including #{@weapon.dmg_increase} from #{@weapon.name})\nEvasion: #{@evasion}\nAccuracy: #{@accuracy}"
  end
  def inspect_items()
    puts "\nInspecting items of #{$player.class}: #{$player.name}..."
    sleep(1)
    puts "\nWeapon:\n#{@weapon.name} - increases damage dealt by #{@weapon.dmg_increase}"
    puts "\nItems:"
    i = 0
    loop do
      if $player.items[i].class == NilClass
        i = 0
        break
      end
      puts "#{$player.items[i].name} (#{$player.items[i].usage}) - #{$player.items[i].desc}"
      i += 1
    end
    begin
      puts "\nType the code of the item you want to use (or 'exit' to quit items)"
      userCode = gets.chomp
      if userCode == "exit"
        if $isFight == true
          get_fight_action
        else
          get_player_action
        end
      else
        i = 0
        loop do
          if $player.items[i].code == userCode
            $player.items[i].use
            $player.items.delete_at(i) if $player.items[i].isConsumable
            break
          end
          i += 1
        end
      end
    rescue NoMethodError
      puts "Please enter valid item code."
      sleep(1.5)
      retry
    end
  end

  def move()
    puts "\nYour current location: #{@location}"
    sleep(1.5)
    $moveZones = Array[]
    4.times { |i| $moveZones.push(ZoneGenerator.new.generated_zone) }
    puts "\nZones you can travel to:"
    $moveZones.each do |zone|
        index = $moveZones.index(zone)
        name = zone.name
        puts "#{name} - #{index}"
    end
    userZone = gets.chomp
    userZone = $moveZones[userZone.to_i]
    puts "\nYour character wanders along... Until he sees #{userZone.desc}."
    $current_zone = userZone
    @location = $current_zone.name
    $current_zone.check_for_enemy(userZone.enemy_name)
  end
  def attack_enemy
    dmg = rand(@dmg_min..@dmg_max)
    $enemy.hp -= dmg
    $enemy.hp = 0 if $enemy.hp <= 0
    puts "\nDealt #{dmg} DMG to #{$enemy.name} (#{$enemy.hp} left)"
    sleep(1.5)
    if $enemy.hp == 0 # defeated enemy
      puts "\nYou defeated #{$enemy.name}!"
      @old_lvl = @lvl
      @exp += $enemy.exp
      @lvl = $exp_levels.select {|exp| exp === @exp }.values.first
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
    if @lvl > @old_lvl
      puts "\nLevel gained!\nYour level is now #{@lvl}."
    end
  end

  attr_reader :name; attr_accessor :lvl, :exp; attr_accessor :location; attr_accessor :hp; attr_accessor :max_hp; attr_accessor :dmg_min; attr_accessor :dmg_max; attr_accessor :dmg; attr_accessor :evasion; attr_accessor :accuracy; attr_reader :skills; attr_accessor :items
end

class Enemy < Character
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
  def initialize()
    @name = "Ghost"
    @max_hp = rand(5..15); @hp = @max_hp
    @exp = rand(4..8)
    @dmg_min = 2; @dmg_max = 5
    @evasion = 60; @evade_chance = rand(1..@evasion)
    @accuracy = 30; @hit_chance = rand(1..@accuracy)
    @skills = ["Crippling Fear"]
    @item_drop = [StainedSheet.new]
  end
  attr_reader :name, :skills, :appear_chance, :item_drop
  attr_accessor :lvl, :hp, :dmg_min, :dmg_max, :dmg, :evasion, :accuracy
end

class Ghoul < Enemy
  def initialize
    @name = "Ghoul"
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
    @name = "Dragon"
    @max_hp = rand(15..24); @hp = @max_hp
    @exp = rand(11..16)
    @dmg_min = 12; @dmg_max = 15; @dmg = rand(@dmg_min..@dmg_max)
    @evasion = 10; @evade_chance = rand(1..@evasion)
    @accuracy = 40; @hit_chance = rand(1..@accuracy)
    @skills = ["Breathe Fire"]
    @item_drop = [DragonEye.new]
  end
  attr_reader :name, :skills, :appear_chance, :item_drop
  attr_accessor :lvl, :hp, :dmg_min, :dmg_max, :dmg, :evasion, :accuracy
end

class Vampire < Enemy
  def initialize
    @name = "Vampire"
    @max_hp = rand(8..14); @hp = @max_hp
    @exp = rand(9..13)
    @dmg_min = 8; @dmg_max = 12; @dmg = rand(@dmg_min..@dmg_max)
    @evasion = 30; @evade_chance = rand(1..@evasion)
    @accuracy = 80; @hit_chance = rand(1..@accuracy)
    @skills = ["Ritual of Blood Moon", "Invisibility"]
    @item_drop = [VampireTeeth.new]
  end
  attr_reader :name, :skills, :appear_chance, :item_drop
  attr_accessor :lvl, :hp, :dmg_min, :dmg_max, :dmg, :evasion, :accuracy
end
