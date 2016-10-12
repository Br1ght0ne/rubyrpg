require_relative('../modules/fetch')
require_relative('../modules/load_and_save')
require_relative('../../lib/items/inventory')
require_relative('../../lib/items/equipment')
require_relative('../modules/fetch')
require_relative('../modules/fight')
# Class for handling player state and interactions with world/self
class Player
  include LoadAndSave
  include Fetch
  include Fight

  def initialize(name)
    @name = name.capitalize
    @inventory = Inventory.new
    @equipment = Equipment.new
    fetch_state
    fetch_char
  end

  attr_accessor :inventory, :equipment

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
    show_inventory
  end

  private

  def show_inventory
    show_items
    begin
      code = ask_for_code
      use_or_die(code)
    rescue NoMethodError
      puts 'Please enter valid item code.'
      sleep(1.5)
      retry
    end # resuce block
  end

  # show_inventory
  # rubocop:enable AbcSize
  # rubocop:enable MethodLength

  def ask_for_code
    puts "\nType the code of the item you want to use "\
         "(or 'exit' to quit items)"
    gets.chomp
  end

  def use_or_die(code)
    case code
      when 'exit'
        check_for_fight
      else
        use_item(code)
    end # case
  end

  def show_items
    i = 0
    loop do
      break if @inventory.items[i].nil?
      puts "#{@inventory.items[i].name} "\
           "(#{@inventory.items[i].usage}) - "\
           "#{@inventory.items[i].desc}"
      i += 1
    end # loop
  end

  def use_item(code)
    i = 0
    items = @inventory.items
    loop do
      items[i].use if items[i].code == code
      items.delete_at(i) if items[i].is_consumable
      check_for_fight
      i += 1
    end # loop
  end

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
    user_zone = get_zone
    puts "\nYour character wanders along... Until he sees #{user_zone.desc}."
    $current_zone = user_zone
    @location = $current_zone.name
    $stderr.puts "$current_zone = " + $current_zone.to_s + ", starting $current_zone#check_for_enemy..."
    $current_zone.check_for_enemy(user_zone.enemy_name)
  end

  private

  def generate_zones(n)
    $move_zones = Array[]
    n.times { |_i| $move_zones.push(ZoneGenerator.new.generated_zone) }
  end

  def print_zones
    $move_zones.each do |zone|
      index = $move_zones.index(zone)
      name = zone.name
      puts "#{name} - #{index}"
    end
  end

  # @return [zone]
  def get_zone
    user_zone = gets.chomp
    $move_zones[user_zone.to_i]
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
    @lvl = Numbers::EXP_LEVELS.select { |exp| exp === @exp }.values.first
    @next_lvl = @lvl + 1
    @next_level_exp = Numbers::EXP_LEVELS.key(@next_lvl).begin
    @to_next_level = @next_level_exp - @exp
    sleep(1.5)
  end

  # rubocop:enable CaseEquality

  def end_fight
    $enemy.send(:drop)
    $enemy = nil
    $is_fight = false
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