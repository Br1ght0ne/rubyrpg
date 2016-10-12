require_relative('../modules/fight')
require_relative('../items/droppable')

# generic enemy class to import modules
class Enemy
  include Fight

  def spawn
    puts "\nA fearsome #{@name} stands on your way! Engaging in fight..."
    $is_fight = true
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

  def drop
    puts "\nUpon death #{$enemy.name} dropped:"
    self.item_drop.each do |item|
      puts "#{item.name} (#{item.type})"
    end
    puts "\na - take all | d - don\'t take"
    take_item = gets.chomp
    if take_item == 'a'
      self.item_drop.each do |item|
        $player.inventory.new_item(item)
      end
    end
  end

  private

  def check_for_player_death
    if $player.hp > 0
      fight_action
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
