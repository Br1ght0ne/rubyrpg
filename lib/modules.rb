module TextBlocks
  def start
    require_relative "build_info"
    puts "\n\n"
    puts "      #######     "
    puts "     #&&&&&&&#    "
    puts "      #&&&&&#     "
    puts "       #&&&#      "
    puts "        #&#       "
    puts "         #        "
    puts "                  "
    puts "  #### #### ####  "
    puts "  #  # #  # #     "
    puts "  #### #### # ##  "
    puts "  # #  #    #  #  "
    puts "  #  # #    ####  "
    puts "\n"
    puts "Welcome to #{$game_name} #{$game_version} #{$game_version_tag}! \n"
    sleep(1.5)
    puts "\nEnter the name for your character:"
    name = gets.chomp.capitalize
    $player = Player.new(name)
    puts "\nLet's start your adventure, #{$player.name}!\n"
    sleep(1.5)

    get_player_action()

  end
end

module Action
  def get_player_action()
    puts "\nWhat do you want to do?\nd - display information about you | i - inspect your items | m - move to some location | t - TERMINATE GAME"
    user_action = gets.chomp
    case user_action
    when "d"
      $player.display_player_info()
      sleep(2)
      get_player_action()
    when "i"
      $player.inspect_items()
      sleep(2)
      get_player_action()
    when "m"
      $player.move()
      sleep(2)
      get_player_action()
    when "t"
      puts "\nTerminating game... Farewell!"
      sleep(1)
      exit
    else
      get_player_action
    end
  end
  def get_fight_action
    puts "\nWhat do you want to do?\na - attack enemy | i - inspect your items | s - inspect your skills | t - TERMINATE GAME"
    user_action = gets.chomp
    case user_action
    when "a" || "attack"
      $player.attack_enemy
    when "i"
      $player.inspect_items()
      sleep(2)
      get_player_action()
    when "s"
      $player.inspect_skills()
      sleep(2)
      get_player_action()
    when "t"
      puts "\nTerminating game... Farewell!"
      sleep(1)
      exit
    else
      get_fight_action
    end
  end
  def check_for_restart
    puts "Do you want to start over? y/n"; restart = gets.chomp
    case restart
    when "y" || "yes"
      start
    when "n" || "no"
      puts "Goodbye, though!"
      sleep(1)
      exit
    end
  end
end

module Drop
  def drop
    puts "\nUpon death #{$enemy.name} dropped:"
    $enemy.item_drop.each do |item|
      puts "#{item.name} (#{item.type})"
    end
    puts "\na - take all | d - don\'t take"
    takeItem = gets.chomp
    case takeItem
    when "a"
      $enemy.item_drop.each do |item|
        $player.items.push(item)
      end
    when "d"

    end
  end
end
