# My additions
require_relative 'lib/characters'
require_relative 'lib/character_actions'
require_relative 'lib/zones'
require_relative 'lib/modules'
require_relative 'lib/items'
include TextBlocks
include Action

# NOTE: Chances and classes
$enemy_appear_chance = Hash["Ghost" => 60, "Ghoul" => 40, "Dragon" => 25, "Vampire" => 40]
$enemy_class = Hash["Ghost" => Ghost, "Ghoul" => Ghoul, "Dragon" => Dragon, "Vampire" => Vampire]
$exp_levels = {
  0..19 => 1,
  20..49 => 2,
  50..89 => 3,
  90..139 => 4,
  140..199 => 5
}
# NOTE: Beginning of the game
start
