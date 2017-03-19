module LoadAndSave
  def save_game
    Dir.mkdir('saves') unless Dir.exist?('saves')
    t = Time.now
    stamp = t.strftime('%Y%m%d%H%M%S')
    File.open("saves/save_#{$player.name}_"\
              "#{$player.object_id}_#{stamp}.sav", 'w') do |to_file|
      Marshal.dump($player, to_file)
    end
    puts "\nSaved!"
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
      show_saves(all_saves)
      sleep(1.5)
      player_action
    end
  end

  def show_saves(_saves)
    all_saves.each_with_index { |rec, i| puts "#{rec} - #{i + 1}" }
    puts "\nEnter the number of the save file:"
    load_number = gets.chomp.to_i - 1
    File.open("saves/#{all_saves[load_number.to_i]}", 'r') do |from_file|
      $player = Marshal.load(from_file)
    end
    puts "\nLoaded player: #{$player.name} (exp: #{$player.exp})."
    File.delete("saves/#{all_saves[load_number.to_i]}")
  end
end
