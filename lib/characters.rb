require_relative 'zones'

class Character
  # include Fighting; include Movement; include Talking; include Skills
end

class Player < Character
  require_relative 'items'
  # include Exp
  def initialize(name)
    @name = name.capitalize
    @lvl = 1
    @max_hp = 100; @hp = @max_hp
    @base_dmg_min = 3; @base_dmg_max = 8
    @evasion = 20; @evade_chance = rand(1..@evasion)
    @accuracy = 70;  @hit_chance = rand(1..@accuracy)
    @skills = []
    @weapon = Weapon.new('Handmade Dagger',2)
    @dmg_min = @base_dmg_min + @weapon.dmg_increase; @dmg_max = @base_dmg_max + @weapon.dmg_increase
    @dmg = rand(@dmg_min..@dmg_max)
    @items = [HealthPotion.new("Small Health Potion",20)]
  end

  def display_player_info(player)
    puts "\nDisplaying info for #{player.class}: #{player.name}..."
    sleep(0.5)
    puts "\nName: #{player.name}\nLevel: #{player.lvl}\nHP: #{player.hp}/#{player.max_hp}\nDamage: #{player.dmg_min}-#{player.dmg_max} (including #{@weapon.dmg_increase} from #{@weapon.name})\nEvasion: #{player.evasion}\nAccuracy: #{player.accuracy}"
  end
  def inspect_items(player)
    puts "\nInspecting items of #{player.class}: #{player.name}..."
    sleep(1)
    puts "\nWeapon:\n#{@weapon.name} - increases damage dealt by #{@weapon.dmg_increase}"
    puts "\nItems:\n#{@items[0].name} - #{@items[0].desc}"
  end
  def move(player)
    puts "\nNot working yet. Told ya."
    #@destinations = Array.new
    #@destinations.push(rand(Zone.class_variable_get(:@@zones_names))
    #@destinations.push(rand(Zone.class_variable_get(:@@zones_names))
    #puts "#{@destinations[0]} | #{@destinations[1]}"
  end
  attr_reader :name; attr_accessor :lvl; attr_accessor :hp; attr_accessor :max_hp; attr_accessor :dmg_min; attr_accessor :dmg_max; attr_accessor :dmg; attr_accessor :evasion; attr_accessor :accuracy; attr_reader :skills
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
