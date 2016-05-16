# My additions
require_relative 'lib/characters'
require_relative 'lib/character_actions'
require_relative 'lib/zones'
require_relative 'lib/modules'
require_relative 'lib/items'
include TextBlocks
include Action

# NOTE: Beginning of the game
start
sleep(2)

# NOTE: Chances and classes
$enemy_appear_chance = Hash["Ghost" => 60, "Ghoul" => 40, "Dragon" => 25, "Vampire" => 40]
$enemy_class = Hash["Ghost" => Ghost, "Ghoul" => Ghoul, "Dragon" => Dragon, "Vampire" => Vampire]

puts "\nEnter the name for your character:"
name = gets.chomp.capitalize
$player = Player.new(name)
puts "\nLet's start your adventure, #{$player.name}!\n"
sleep(1.5)

get_player_action()
