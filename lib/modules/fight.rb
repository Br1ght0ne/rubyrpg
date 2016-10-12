module Fight
  def fight_action
    $is_fight = true
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

  def check_for_fight
    $is_fight ? fight_action : player_action
  end
end