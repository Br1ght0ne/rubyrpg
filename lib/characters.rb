require_relative 'zones'
require_relative 'modules'
class Character
  # include Fighting; include Movement; include Talking; include Skills
end

class Player < Character
  # include Exp
  def initialize(name)
    @name = name.capitalize
    @lvl = 1
    $current_zone = StartZone.new
    @location = $current_zone.name
    @max_hp = 100; @hp = @max_hp
    @base_dmg_min = 3; @base_dmg_max = 8
    @evasion = 20; @evade_chance = rand(1..@evasion)
    @accuracy = 70;  @hit_chance = rand(1..@accuracy)
    @skills = []
    @weapon = Weapon.new('Handmade Dagger',2)
    @dmg_min = @base_dmg_min + @weapon.dmg_increase; @dmg_max = @base_dmg_max + @weapon.dmg_increase
    @dmg = rand(@dmg_min..@dmg_max)
    @items = [SmallHealthPotion.new]
  end

  def display_player_info()
    puts "\nDisplaying info for #{$player.class}: #{$player.name}..."
    sleep(1)
    puts "\nName: #{$player.name}\nLevel: #{$player.lvl}\nHP: #{$player.hp}/#{$player.max_hp}\nDamage: #{$player.dmg_min}-#{$player.dmg_max} (including #{@weapon.dmg_increase} from #{@weapon.name})\nEvasion: #{$player.evasion}\nAccuracy: #{$player.accuracy}"
  end
  def inspect_items()
    puts "\nInspecting items of #{$player.class}: #{$player.name}..."
    sleep(1)
    puts "\nWeapon:\n#{@weapon.name} - increases damage dealt by #{@weapon.dmg_increase}"
    puts "\nItems:"
    i = 0
    loop do
      break if $player.items[i].class == NilClass
      puts "#{$player.items[i].name}(#{$player.items[i].code}) - #{@items[i].desc}" if $player.items[i].class != NilClass
      i += 1
    end
    puts "Type the code of the item you want to use (or 'exit' to quit items)"
    i = gets.chomp; i.upcase!
    if i == "EXIT"
      get_player_action
    else
      # TODO: Item use
    end
  end
  def move()
    puts "\nYour current location: #{$player.location}"
    sleep(1.5)
    $current_zone = ZoneGenerator.new.generated_zone
    $player.location = $current_zone.name
    puts "\nYour character wanders along... Until he sees #{$current_zone.desc}."
    $current_zone.check_for_enemy($current_zone.enemy_name)
  end
  attr_reader :name; attr_accessor :lvl; attr_accessor :location; attr_accessor :hp; attr_accessor :max_hp; attr_accessor :dmg_min; attr_accessor :dmg_max; attr_accessor :dmg; attr_accessor :evasion; attr_accessor :accuracy; attr_reader :skills; attr_accessor :items
end

class Enemy < Character
  public
  def spawn
    puts "A fearsome #{@name} stands on your way! Engaging in fight..."
    sleep(1.5)
  end
end

class Ghost < Enemy
  def initialize()
    @name = "Ghost"
    @max_hp = rand(5..15); @hp = @max_hp
    @dmg_min = 2; @dmg_max = 5; @dmg = rand(@dmg_min..@dmg_max)
    @evasion = 60; @evade_chance = rand(1..@evasion)
    @accuracy = 30; @hit_chance = rand(1..@accuracy)
    @skills = ["Crippling Fear"]
  end
  attr_reader :name, :skills, :appear_chance
  attr_accessor :lvl, :hp, :dmg_min, :dmg_max, :dmg, :evasion, :accuracy
end

class Ghoul < Enemy
  def initialize
    @name = "Ghoul"
    @max_hp = rand(9..11); @hp = @max_hp
    @dmg_min = 7; @dmg_max = 11; @dmg = rand(@dmg_min..@dmg_max)
    @evasion = 15; @evade_chance = rand(1..@evasion)
    @accuracy = 65; @hit_chance = rand(1..@accuracy)
    @skills = []
  end
  attr_reader :name; attr_accessor :lvl; attr_accessor :hp
  attr_accessor :dmg_min; attr_accessor :dmg_max; attr_accessor :dmg
  attr_accessor :evasion; attr_accessor :accuracy; attr_reader :skills
end

class Dragon < Enemy
  def initialize
    @name = "Dragon"
    @max_hp = rand(15..24); @hp = @max_hp
    @dmg_min = 12; @dmg_max = 15; @dmg = rand(@dmg_min..@dmg_max)
    @evasion = 10; @evade_chance = rand(1..@evasion)
    @accuracy = 40; @hit_chance = rand(1..@accuracy)
    @skills = ["Breathe Fire"]
  end
  attr_reader :name; attr_accessor :lvl; attr_accessor :hp
  attr_accessor :dmg_min; attr_accessor :dmg_max; attr_accessor :dmg
  attr_accessor :evasion; attr_accessor :accuracy; attr_reader :skills
end

class Vampire < Enemy
  def initialize
    @name = "Vampire"
    @max_hp = rand(8..14); @hp = @max_hp
    @dmg_min = 8; @dmg_max = 12; @dmg = rand(@dmg_min..@dmg_max)
    @evasion = 30; @evade_chance = rand(1..@evasion)
    @accuracy = 80; @hit_chance = rand(1..@accuracy)
    @skills = ["Ritual of Blood Moon", "Invisibility"]
  end
  attr_reader :name; attr_accessor :lvl; attr_accessor :hp
  attr_accessor :dmg_min; attr_accessor :dmg_max; attr_accessor :dmg
  attr_accessor :evasion; attr_accessor :accuracy; attr_reader :skills
end
