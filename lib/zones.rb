require_relative "characters"
class Zone
end

class ZoneGenerator
  def initialize
    @@zones = [Graveyard.new, Forest.new]
    @generated_zone = @@zones.sample
  end
  attr_reader :zones; attr_reader :generated_zone
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
    @name = "Graveyard"; @code = "GR#{@graveyard_number}"
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
    @name = "Forest"; @code = "FO#{@forest_number}"
    @desc = "a thick forest"
    # FIXME: @ghoul_appear = true if rand(1..100) <=  Ghoul.@@appear_chance
    # FIXME: Ghoul.new if @ghoul_appear == true
  end
  attr_reader :name, :forest_number, :code, :desc
  # FIXME: attr_reader :ghoul_appear
end

class Cave < Zone
  @@cave_count = 0
  def initialize
    @@cave_count +=1; @cave_number = @@cave_count
    @name = "Cave"; @code = "CV#{@cave_number}"
    @desc = "a deep cave"
    # FIXME: @ghoul_appear = true if rand(1..100) <=  Ghoul.@@appear_chance
    # FIXME: Ghoul.new if @ghoul_appear == true
  end
  attr_reader :name, :cave_number, :code, :desc
  # FIXME: attr_reader :ghoul_appear
end

class Castle < Zone
  @@castle_count = 0
  def initialize
    @@castle_count +=1; @castle_number = @@castle_count
    @name = "Castle"; @code = "CS#{@cave_number}"
    @desc = "an ancient castle"
    # FIXME: @ghoul_appear = true if rand(1..100) <=  Ghoul.@@appear_chance
    # FIXME: Ghoul.new if @ghoul_appear == true
  end
  attr_reader :name, :castle_number, :code, :desc
  # FIXME: attr_reader :ghoul_appear
end
