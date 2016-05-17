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

# NOTE: Beginning of the game
start
