class Item

end

class Weapon < Item
  def initialize(name,dmg_increase)
    @name = name; @dmg_increase = dmg_increase
  end
  attr_reader :name; attr_accessor :dmg_increase
end

class Potion < Item

end

class HealthPotion < Potion
  def initialize(name,hp_restore)
    @name = name; @hp_restore = hp_restore
    @desc = "increases current HP by #{@hp_restore}"
  end
  attr_reader :name; attr_reader :hp_restore; attr_reader :desc
end
