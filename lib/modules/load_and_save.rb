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
      start_new = gets.chomp
      case start_new
        when 'y'
          game_begin
        else
          puts "\nOkay then. Farewell!"
          exit
      end
    else
      all_saves.each_with_index do |record, index|
        shown_index = index + 1
        puts "#{record} - #{shown_index}"
      end
      puts "\nEnter the number of the save file:"
      shown_load_number = gets.chomp
      load_number = shown_load_number.to_i - 1
      File.open("saves/#{all_saves[load_number.to_i]}", 'r') { |from_file| $player = Marshal.load(from_file) }
      puts "\nLoaded player: #{$player.name} (exp: #{$player.exp})."
      File.delete("saves/#{all_saves[load_number.to_i]}")
      sleep(1.5)
      player_action
    end
  end
end