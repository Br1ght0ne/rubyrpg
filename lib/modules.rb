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

    $enemy_appear_chance = Hash["Ghost" => 80, "Ghoul" => 40]
    $enemy_class = Hash["Ghost" => Ghost, "Ghoul" => Ghoul]
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
end
