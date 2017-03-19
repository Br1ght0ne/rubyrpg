module Fight
  @action_list = { 'a' => :attack_enemy,
                   'i' => :inspect_items,
                   's' => :inspect_skills,
                   'x' => :save_game }
  def fight_action
    $is_fight = true
    puts "\nWhat do you want to do?\na - attack enemy | i - inspect your items"\
           ' | s - inspect your skills | x - save and exit'
    user_action = gets.chomp
    $player.send(@action_list[user_action])
    sleep(2)
    user_action == 'x' ? exit : fight_action
  end

  def check_for_fight
    $is_fight ? fight_action : player_action
  end
end
