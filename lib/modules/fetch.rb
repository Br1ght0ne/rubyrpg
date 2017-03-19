require_relative('../zones/zones')
require_relative('../modules/numbers')

module Fetch
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
    @equipment.helmet.increase_value +
      @equipment.armor.increase_value +
      @equipment.gloves.increase_value +
      @equipment.boots.increase_value +
      @equipment.leggings.increase_value
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
    @lvl = Numbers::EXP_LEVELS.select do |level|
      level.include?(@exp)
    end.values.first
    @next_lvl = @lvl + 1
    @next_level_exp = Numbers::EXP_LEVELS.key(@next_lvl).begin.to_i
    @to_next_level = @next_level_exp - @exp
  end
end
