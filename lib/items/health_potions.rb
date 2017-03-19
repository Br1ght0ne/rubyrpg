class HealthPotion
  def initialize
    @usage = "type #{@code} to use"
    @is_consumable = true
    @desc = "restores your HP by #{@hp_restore}"
  end

  def use
    if $player.hp == $player.max_hp
      raise RuntimeError, "You can\'t use health potions while "\
      'you have full HP.', caller
    end
    healed = heal
    puts "Restored #{healed} HP."
  rescue => ex
    puts ex.message
    sleep(1.5)
    $player.inspect_items
  end

  def heal
    hp_before_heal = $player.hp
    $player.hp += @hp_restore
    $player.hp = $player.max_hp if $player.hp > $player.max_hp
    $player.hp - hp_before_heal
  end
end

class SmallHealthPotion < HealthPotion
  def initialize
    @code = 'SHP'
    @name = 'Small Health Potion'
    @hp_restore = 20
    super
  end

  attr_reader :name, :code, :hp_restore, :desc, :is_consumable, :usage
end
