module Fighting
  def attack(attacker, target)
  end
end

module Items
  def inspect_items(player)
    puts "\nDisplaying info for #{player.class}: #{player.name}..."
    sleep(0.5)
    puts "\nName: #{player.name}\nLevel: #{player.lvl}\nHP: #{player.hp}\nDamage: #{player.dmg_min}-#{player.dmg_max}\nEvasion: #{player.evasion}\nAccuracy: #{player.accuracy}"
  end
end
# Movement Talking Skills Items Exp Drop
