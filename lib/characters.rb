require_relative 'zones'

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
    sleep(0.5)
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
    # TODO: Move method
    puts "Your current location: #{$player.location}"
    sleep(1.5)
    $current_zone = ZoneGenerator.new.generated_zone
    $player.location = $current_zone.name
    puts "Your character wanders along... Until he sees #{$current_zone.desc}."
  end
  attr_reader :name; attr_accessor :lvl; attr_accessor :location; attr_accessor :hp; attr_accessor :max_hp; attr_accessor :dmg_min; attr_accessor :dmg_max; attr_accessor :dmg; attr_accessor :evasion; attr_accessor :accuracy; attr_reader :skills; attr_accessor :items
end

class Enemy < Character
  #include Drop
end

class Ghost < Enemy
  @@appear_chance = 80
  def initialize()
    @name = "Ghost"
    @max_hp = rand(5..15); @hp = @max_hp
    @dmg_min = 2; @dmg_max = 5; @dmg = rand(@dmg_min..@dmg_max)
    @evasion = 60; @evade_chance = rand(1..@evasion)
    @accuracy = 30; @hit_chance = rand(1..@accuracy)
    @skills = ["Crippling Fear"]
  end
  attr_reader :name; attr_accessor :lvl; attr_accessor :hp
  attr_accessor :dmg_min; attr_accessor :dmg_max; attr_accessor :dmg
  attr_accessor :evasion; attr_accessor :accuracy; attr_reader :skills
  attr_reader :appear_chance
end

class Ghoul < Enemy
  @@appear_chance = 40
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
  attr_reader :appear_chance
end
