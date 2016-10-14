class Clothing
  def initialize(def_increase)
    @increase_type = 'defense'
    @increase_value = def_increase
  end

  attr_reader :increase_type, :name, :increase_value
end

class Helmet < Clothing
  def initialize(name, def_increase)
    @name = name
    @type = 'Helmet'
    super(def_increase)
  end

  attr_reader :type
end

class Armor < Clothing
  def initialize(name, def_increase)
    @name = name
    @type = 'Armor'
    super(def_increase)
  end

  attr_reader :type
end

class Gloves < Clothing
  def initialize(name, def_increase)
    @name = name
    @type = 'Gloves'
    super(def_increase)
  end

  attr_reader :type
end

class Cape < Clothing
  def initialize(name, def_increase)
    @name = name
    @type = 'Cape'
    super(def_increase)
  end

  attr_reader :type
end

class Boots < Clothing
  def initialize(name, def_increase)
    @name = name
    @type = 'Boots'
    super(def_increase)
  end

  attr_reader :type
end

class Leggings < Clothing
  def initialize(name, def_increase)
    @name = name
    @type = 'Leggings'
    super(def_increase)
  end

  attr_reader :type
end

class Jewelry
  def initialize(increase_type, increase_value)
    @increase_type = increase_type
    @increase_value = increase_value
  end

  attr_reader :name, :increase_type, :type, :increase_value
end

class RingLeft < Jewelry
  def initialize(name, increase_type, increase_value)
    @name = name
    @type = 'Ring (left hand)'
    super(increase_type, increase_value)
  end

  attr_reader :type
end

class RingRight < Jewelry
  def initialize(name, increase_type, increase_value)
    @name = name
    @type = 'Ring (right hand)'
    super(increase_type, increase_value)
  end

  attr_reader :type
end

class Amulet < Jewelry
  def initialize(name, increase_type, increase_value)
    @name = name
    @type = 'Amulet'
    super(increase_type, increase_value)
  end

  attr_reader :type
end

class Belt < Jewelry
  def initialize(name, increase_type, increase_value)
    @name = name
    @type = 'Belt'
    super(increase_type, increase_value)
  end

  attr_reader :type
end