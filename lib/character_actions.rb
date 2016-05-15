module Fighting
  def attack(attacker, target)
  end
end

module Items
  def inspect_items(player)
    puts "\nDisplaying info for #{player.class}: #{player.name}..."
    sleep(0.5)
    puts "\nName: #{player.name}\nLevel: #{player.lvl}\nHP: #{player.hp}\n
    Damage: #{player.dmg_min}-#{player.dmg_max}\n
    Evasion: #{player.evasion}\nAccuracy: #{player.accuracy}"
  end
end

module Movement
end
# Talking Skills Items Exp Drop
