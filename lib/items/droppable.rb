class Junk
  def initialize
    @usage = 'junk, no use'
    @is_consumable = true
    @desc = 'should be sold in shop'
  end

  attr_reader :usage, :is_consumable, :desc
end

class StainedSheet < Junk
  def initialize
    super
    @name = 'Stained Sheet'
    @type = 'Junk'
    @value = 3
  end

  attr_reader :name, :type, :value
end

class GhoulSkin < Junk
  def initialize
    super
    @name = 'Ghoul Skin'
    @type = 'Junk'
    @value = 5
  end

  attr_reader :name, :type, :value
end

class DragonEye < Junk
  def initialize
    super
    @name = 'Dragon Eye'
    @type = 'Junk'
    @value = 30
  end

  attr_reader :name, :type, :value
end

class VampireTeeth < Junk
  def initialize
    super
    @name = 'Vampire Teeth'
    @type = 'Junk'
    @value = 12
  end

  attr_reader :name, :type, :value
end
