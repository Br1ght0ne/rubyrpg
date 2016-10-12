require_relative('../../lib/characters/player')

module Action
  def game_begin
    puts "\nEnter name for your character:"
    name = gets.chomp.capitalize
    $player = Player.new(name)
    puts "\nLet's start your adventure, #{$player.name}!\n"
    sleep(1.5)
    player_action
  end

  def player_action
    puts "\nWhat do you want to do?\nd - display information about you | "\
         "i - inspect your items\nm - move to some location | x - exit game"
    user_action = gets.chomp
    case user_action
      when 'd'
        $player.display_player_info
        sleep(2)
        player_action
      when 'i'
        $player.inspect_items
        sleep(2)
        player_action
      when 'm'
        $player.move
        sleep(2)
        player_action
      when 's'
        $player.save_game
        sleep(2)
        player_action
      when 'x'
        $player.save_game
        sleep(1)
        exit
      else
        player_action
    end
  end

  def check_for_restart
    puts 'Do you want to start over? y/n'; restart = gets.chomp
    case restart
      when 'y' || 'yes'
        start
      else
        puts 'Goodbye, though!'
        sleep(1)
        exit
    end
  end
end