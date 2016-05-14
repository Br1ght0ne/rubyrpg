class Zone
  @@zones_names = ["Graveyard", "Forest", "Cave", "Castle"]
  attr_reader :zones_names
end

class Graveyard < Zone
  @@graveyard_count = 0
  def initialize
    @@graveyard_count += 1; @graveyard_number = @@graveyard_count
    @name = "Graveyard"; @code = "g"
    @ghost_appear = true if rand(1..100) <= Ghost.appear_chance
    Ghost.new if @ghost_appear == true
  end
  attr_reader :name; attr_reader :graveyard_number; attr_reader :code;
  attr_reader :ghost_appear
end
