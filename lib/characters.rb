require_relative 'zones'
require_relative 'modules'
require_relative 'items'

# Class for handling player state and interactions with world/self
class Player
  include LoadAndSave

  def initialize(name)
    @name = name.capitalize
    @inventory = Inventory.new
    @equipment = Equipment.new
    fetch_state
    fetch_char
  end

  attr_accessor :inventory, :equipment

  private

  def fetch_state
    $current_zone = StartZone.new
    @location = $current_zone.name
  end

  def fetch_skills
    @skills = []
  end

  def fetch_char
    fetch_hp(100)
    fetch_def(0, 4)
    fetch_dmg(3, 8)
    fetch_evasion(20)
    fetch_accuracy(70)
    fetch_exp(0)
  end

  def fetch_hp(max_hp)
    @max_hp = max_hp
    @hp = @max_hp
  end

  def fetch_def(min, max)
    @armor_value = calculate_armor_value
    @def_min = min + @armor_value
    @def_max = max + @armor_value
  end

  def calculate_armor_value
    value = @equipment.helmet.increase_value +
            @equipment.armor.increase_value +
            @equipment.gloves.increase_value +
            @equipment.boots.increase_value +
            @equipment.leggings.increase_value
    value
  end

  def fetch_dmg(min, max)
    @dmg_min = min + @equipment.weapon.dmg_increase
    @dmg_max = max + @equipment.weapon.dmg_increase
  end

  def fetch_evasion(chance)
    @evasion = chance
    @evade_chance = rand(1..@evasion)
  end

  def fetch_accuracy(chance)
    @accuracy = chance
    @hit_chance = rand(1..@accuracy)
  end
  def fetch_exp(exp)
    @exp = exp
    @lvl = $exp_levels.select { |level| level === @exp }.values.first
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
         "(including #{@equipment.weapon.dmg_increase} "\
         "from #{@equipment.weapon.name})\n"\
         "Defense: #{@def_min}-#{@def_max} (including #{@armor_value} "\
         "from equipped items)\nEvasion: #{@evasion}\nAccuracy: #{@accuracy}"
  end

  def inspect_items
    puts "\nInspecting items of #{$player.class}: #{$player.name}..."
    sleep(1)
    @equipment.list
    puts "\nItems:"
    item_show_loop
  end

  private
  def item_show_loop
    i = 0
    loop do
      if $player.inventory.items[i].class == NilClass
        i = 0
        break
      end # if
      puts "#{$player.inventory.items[i].name} "\
           "(#{$player.inventory.items[i].usage}) - "\
           "#{$player.inventory.items[i].desc}"
      i += 1
    end # loop
    begin
      puts "\nType the code of the item you want to use "\
           "(or 'exit' to quit items)"
      user_code = gets.chomp
      if user_code == 'exit'
        check_for_fight
      else
        i = 0
        loop do
          if $player.inventory.items[i].code == user_code
            $player.inventory.items[i].use
            if $player.inventory.items[i].is_consumable
              $player.inventory.items.delete_at(i)
            end
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
  # rubocop:enable AbcSize
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
    generate_zones(4)
    puts "\nZones you can travel to:"
    print_zones
    user_zone = zone
    puts "\nYour character wanders along... Until he sees #{user_zone.desc}."
    # puts 'DEBUG: CHECK FOR ENEMY STARTING'
    $current_zone = user_zone
    @location = $current_zone.name
    $current_zone.check_for_enemy(user_zone.enemy_name)
    # puts 'DEBUG: CHECK FOR ENEMY COMPLETED'
  end

  private

  def generate_zones(n)
    $moveZones = Array[]
    n.times { |_i| $moveZones.push(ZoneGenerator.new.generated_zone) }
  end

  def print_zones
    $moveZones.each do |zone|
      index = $moveZones.index(zone)
      name = zone.name
      puts "#{name} - #{index}"
    end
  end

  def zone
    user_zone = gets.chomp
    zone = $moveZones[user_zone.to_i]
    zone
  end

  public

  def attack_enemy
    dmg = rand(@dmg_min..@dmg_max)
    $enemy.hp -= dmg
    $enemy.hp = 0 if $enemy.hp <= 0
    puts "\nDealt #{dmg} DMG to #{$enemy.name} (#{$enemy.hp} left)"
    sleep(1.5)
    check_if_defeated
  end

  private

  def check_if_defeated
    if $enemy.hp.zero? # defeated enemy
      puts "\nYou defeated #{$enemy.name}!"
      change_experience
      puts "\nGained #{$enemy.exp} experience (#{@to_next_level} "\
           "to next level).\n"
      check_for_level_change
      end_fight
    else
      $enemy.send(:attack_player)
    end
  end
  def change_experience
    @old_lvl = @lvl
    @exp += $enemy.exp
    @lvl = $exp_levels.select { |exp| exp === @exp }.values.first
    @next_lvl = @lvl + 1
    @next_level_exp = $exp_levels.key(@next_lvl).begin
    @to_next_level = @next_level_exp - @exp
    sleep(1.5)
  end
  # rubocop:enable CaseEquality

  def end_fight
    $enemy.send(:drop)
    $enemy = nil
    $isFight = false
  end

  public

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
# rubocop:enable ClassLength

# generic enemy class to import modules
class Enemy
  include Action
  include Drop

  def spawn
    puts "\nA fearsome #{@name} stands on your way! Engaging in fight..."
    $isFight = true
    sleep(1.5)
    puts "\nYour HP: #{$player.hp} | #{@name}\'s HP: #{@hp}"
    fight_action
  end

  def attack_player
    dmg = rand(@dmg_min..@dmg_max)
    $player.hp -= dmg
    puts "\n#{@name} deals #{dmg} DMG to #{$player.name}!"
    sleep(1.5)
    puts "\nYour HP: #{$player.hp} | #{@name}\'s HP: #{@hp}"
    sleep(1.5)
    check_for_player_death
  end

  private

  def check_for_player_death
    if $player.hp > 0
<<<<<<< HEAD
      fight_action
=======
      get_fight_action
>>>>>>> c7f7c2a32ef1ac762c8eb917789204d5d19e287e
    else
      $player = nil
      puts "You were killed by #{@name}.\n"
      check_for_restart
    end
  end

  def fetch_hp(min, max)
    @max_hp = rand(min..max)
    @hp = @max_hp
  end

  def fetch_exp(min, max)
    @exp = rand(min..max)
  end

  def fetch_dmg(min, max)
    @dmg_min = min
    @dmg_max = max
    @dmg = rand(@dmg_min..@dmg_max)
  end

  def fetch_evasion(chance)
    @evasion = chance
    @evade_chance = rand(1..@evasion)
  end

  def fetch_accuracy(chance)
    @accuracy = chance
    @hit_chance = rand(1..@accuracy)
  end
end

class Ghost < Enemy
  def initialize
    @name = 'Ghost'
    fetch_hp(5, 15)
    fetch_exp(4, 8)
    fetch_dmg(2, 5)
    fetch_evasion(60)
    fetch_accuracy(30)
    @skills = ['Crippling Fear']
    @item_drop = [StainedSheet.new]
  end
  attr_accessor :hp, :dmg, :dmg_min, :dmg_max
  attr_accessor :evasion, :evade_chance, :accuracy, :hit_chance
  attr_reader :name, :skills, :item_drop, :exp, :max_hp
end

class Ghoul < Enemy
  def initialize
    @name = 'Ghoul'
    fetch_hp(9, 11)
    fetch_exp(6, 10)
    fetch_dmg(7, 11)
    fetch_evasion(15)
    fetch_accuracy(65)
    @skills = []
    @item_drop = [GhoulSkin.new]
  end
  attr_accessor :hp, :dmg, :dmg_min, :dmg_max
  attr_accessor :evasion, :evade_chance, :accuracy, :hit_chance
  attr_reader :name, :skills, :item_drop, :exp, :max_hp
end

class Dragon < Enemy
  def initialize
    @name = 'Dragon'
    fetch_hp(13, 24)
    fetch_exp(12, 20)
    fetch_dmg(9, 18)
    fetch_evasion(20)
    fetch_accuracy(80)
    @skills = ['Breathe Fire']
    @item_drop = [DragonEye.new]
  end
  attr_accessor :hp, :dmg, :dmg_min, :dmg_max
  attr_accessor :evasion, :evade_chance, :accuracy, :hit_chance
  attr_reader :name, :skills, :item_drop, :exp, :max_hp
end

class Vampire < Enemy
  def initialize
    @name = 'Dragon'
    fetch_hp(8, 14)
    fetch_exp(9, 13)
    fetch_dmg(8, 12)
    fetch_evasion(30)
    fetch_accuracy(80)
    @skills = ['Ritual of Blood Moon', 'Invisibility']
    @item_drop = [VampireTeeth.new]
  end
  attr_accessor :hp, :dmg, :dmg_min, :dmg_max
  attr_accessor :evasion, :evade_chance, :accuracy, :hit_chance
  attr_reader :name, :skills, :item_drop, :exp, :max_hp
end
