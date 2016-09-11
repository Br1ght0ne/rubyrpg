require_relative 'characters'
require_relative 'modules'
class Zone
    public

  def check_for_enemy(enemy_name)
      if rand(1..100) <= $enemy_appear_chance[enemy_name]
          $enemy = $enemy_class[enemy_name].new
          $enemy.spawn
      end
  end
end

class ZoneGenerator
    def initialize
        @@zones = [Graveyard.new, Forest.new, Cave.new, Castle.new]
        @generated_zone = @@zones.sample
        while @generated_zone.class == $current_zone.class
            @generated_zone = @@zones.sample
        end
    end
    attr_reader :zones; attr_reader :generated_zone
end

class StartZone < Zone
    def initialize
        @name = 'Start Zone'
    end
    attr_reader :name
end

class Graveyard < Zone
    @@graveyard_count = 0
    def initialize
        @@graveyard_count += 1; @graveyard_number = @@graveyard_count
        @enemy_name = 'Ghost'
        @name = 'Graveyard'; @code = "GR#{@graveyard_number}"
        @desc = 'an old graveyard'
    end
    attr_reader :name, :graveyard_number, :code, :desc, :enemy_name
end

class Forest < Zone
    @@forest_count = 0
    def initialize
        @@forest_count += 1; @forest_number = @@forest_count
        @enemy_name = 'Ghoul'
        @name = 'Forest'; @code = "FO#{@forest_number}"
        @desc = 'a thick forest'
    end
    attr_reader :name, :forest_number, :code, :desc, :enemy_name
end

class Cave < Zone
    @@cave_count = 0
    def initialize
        @@cave_count += 1; @cave_number = @@cave_count
        @enemy_name = 'Dragon'
        @name = 'Cave'; @code = "CV#{@cave_number}"
        @desc = 'a deep cave'
    end
    attr_reader :name, :cave_number, :code, :desc, :enemy_name
end

class Castle < Zone
    @@castle_count = 0
    def initialize
        @@castle_count += 1; @castle_number = @@castle_count
        @enemy_name = 'Vampire'
        @name = 'Castle'; @code = "CS#{@cave_number}"
        @desc = 'an ancient castle'
    end
    attr_reader :name, :castle_number, :code, :desc, :enemy_name
end
