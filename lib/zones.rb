require_relative "characters"
class Zone
end

class StartZone < Zone
  def initialize
    @name = "Start Zone"
  end
  attr_reader :name
end

# TODO: появление энеми

class Graveyard < Zone
  @@graveyard_count = 0
  def initialize
    @@graveyard_count += 1; @graveyard_number = @@graveyard_count
    @name = "Graveyard"; @code = "G"
    @desc = "an old graveyard"
    # FIXME: @ghost_appear = true if rand(1..100) <= Ghost.@@appear_chance
    # FIXME: Ghost.new if @ghost_appear == true
  end
  attr_reader :name; attr_reader :graveyard_number; attr_reader :code; attr_reader :desc
  # FIXME: attr_reader :ghost_appear
end

class Forest < Zone
  @@forest_count = 0
  def initialize
    @@forest_count +=1; @forest_number = @@forest_count
    @name = "Forest"; @code = "F"
    @desc = "a thick forest"
    # FIXME: @ghoul_appear = true if rand(1..100) <=  Ghoul.@@appear_chance
    # FIXME: Ghoul.new if @ghoul_appear == true
  end
  attr_reader :name; attr_reader :forest_number; attr_reader :code; attr_reader :desc
  # FIXME: attr_reader :ghoul_appear
end

class ZoneGenerator
  def initialize
    @@zones = [Graveyard.new, Forest.new]
    @generated_zone = @@zones.sample
  end
  attr_reader :zones; attr_reader :generated_zone
end
