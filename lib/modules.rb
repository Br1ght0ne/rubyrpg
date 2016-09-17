module TextBlocks
  def start
    include LoadAndSave
    require_relative 'build_info'
    print_logo
    greet_user
    new_or_load = gets.chomp
    { 's' => game_begin, 'l' => load_game }[new_or_load]
  end

  def greet_user
    puts "Welcome to #{$game_name} #{$game_version} #{$game_version_tag}! \n"
    sleep(1.5)
    puts "\ns - start new adventure | l - load existing character"
  end

  def print_logo
    puts "\n"\
         "      #######     \n"\
         "     #&&&&&&&#    \n"\
         "      #&&&&&#     \n"\
         "       #&&&#      \n"\
         "        #&#       \n"\
         "         #        \n"\
         "                  \n"\
         "  #### #### ####  \n"\
         "  #  # #  # #     \n"\
         "  #### #### # ##  \n"\
         "  # #  #    #  #  \n"\
         "  #  # #    ####  \n"\
         "\n"
  end
  # rubocop:enable MethodLength
end

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

  def fight_action
    $isFight = true
    puts "\nWhat do you want to do?\na - attack enemy | i - inspect your items"\
         ' | s - inspect your skills | x - save and exit'
    user_action = gets.chomp
    case user_action
    when 'a'
      $player.attack_enemy
    when 'i'
      $player.inspect_items
      sleep(2)
      player_action
    when 's'
      $player.inspect_skills
      sleep(2)
      player_action
    when 'x'
      $player.save_game
      sleep(1)
      exit
    else
      fight_action
    end
  end

  def check_for_restart
    puts 'Do you want to start over? y/n'; restart = gets.chomp
    case restart
    when 'y' || 'yes'
      start
    when 'n' || 'no'
      puts 'Goodbye, though!'
      sleep(1)
      exit
    end
  end

  def check_for_fight
    if $isFight == true
      fight_action
    else
      player_action
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
    when 'a'
      $enemy.item_drop.each do |item|
        $player.items.push(item)
      end
    when 'd'

    end
  end
end

module LoadAndSave
  def save_game
    def save_method
      t = Time.now
      stamp = t.strftime('%Y%m%d%H%M%S')
      File.open("saves/save_#{$player.name}_#{$player.object_id}_#{stamp}.sav", 'w') { |to_file| Marshal.dump($player, to_file) }
      puts "\nSaved!"
    end

    if Dir.exist?('saves')
      save_method
    else
      Dir.mkdir('saves')
      save_method
    end
  end

  def load_game
    Dir.mkdir('saves') unless Dir.exist?('saves')
    all_saves = Dir.entries('saves').select { |f| !File.directory? f }
    puts "\nDisplaying all the save files...\n"
    if all_saves.empty?
      puts "\nNo save files found :(\n"
      puts 'Do you want to start a new game? y/n'
      startNew = gets.chomp
      case startNew
      when 'y'
        game_begin
      when 'n'
        puts "\nOkay then. Farewell!"
        exit
      end
    else
      all_saves.each_with_index do |record, index|
        shownIndex = index + 1
        puts "#{record} - #{shownIndex}"
      end
      puts "\nEnter the number of the save file:"
      shownLoadNumber = gets.chomp
      loadNumber = shownLoadNumber.to_i - 1
      File.open("saves/#{all_saves[loadNumber.to_i]}", 'r') { |from_file| $player = Marshal.load(from_file) }
      puts "\nLoaded player: #{$player.name} (exp: #{$player.exp})."
      File.delete("saves/#{all_saves[loadNumber.to_i]}")
      sleep(1.5)
      player_action
    end
  end
end
