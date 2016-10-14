class Weapon
  def initialize(name, dmg_increase)
    @type = 'Weapon'
    @increase_type = 'damage'
    @name = name
    @increase_value = dmg_increase
    @dmg_increase = dmg_increase
  end

  attr_reader :name, :type, :increase_type, :increase_value
  attr_accessor :dmg_increase
end