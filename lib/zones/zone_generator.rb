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