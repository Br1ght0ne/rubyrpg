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
    action_list = { 'd' => :display_player_info,
                    'i' => :inspect_items,
                    'm' => :move,
                    'x' => :save_game }
    puts "\nWhat do you want to do?\nd - display information about you | "\
         "i - inspect your items\nm - move to some location | x - exit game"
    user_action = gets.chomp
    $player.send(action_list[user_action])
    sleep(2)
    user_action == 'x' ? exit : player_action
  end

  def check_for_restart
    puts 'Do you want to start over? y/n'
    restart = gets.chomp
    if restart[0] == 'y'
      start
    else
      puts 'Goodbye, though!'
      sleep(1)
      exit
    end
  end
end
