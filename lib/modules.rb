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
  end
end

module Action
  def get_player_action(player)
    puts "\nWhat do you want to do?\nd - display information about you | i - inspect your items | m - move to some location (ACHTUNG: not yet implemented) | t - TERMINATE GAME"
    user_action = gets.chomp
    case user_action
    when "d"
      player.display_player_info(player)
      sleep(2)
      get_player_action(player)
    when "i"
      player.inspect_items(player)
      sleep(2)
      get_player_action(player)
    when "m"
      player.move(player)
      sleep(2)
      get_player_action(player)
    when "t"
      puts "\nTerminating game... Farewell!"
      sleep(1)
      exit
    end
  end
end
