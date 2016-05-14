# Ruby additons

# my additions
require_relative "lib/characters"
require_relative "lib/character_actions"
require_relative "lib/zones"
require_relative "lib/modules"
include TextBlocks
include Action

start
sleep(2)

puts "\nEnter the name for your character:"
name = gets.chomp.capitalize; player = Player.new(name)
puts "\nLet's start your adventure, #{player.name}!\n"
sleep(1.5)

get_player_action(player)
