#!/usr/bin/env ruby

# My additions
require_relative 'lib/characters'
require_relative 'lib/zones'
require_relative 'lib/modules'
require_relative 'lib/items'
include TextBlocks
include Action

$enemy_appear_chance = { 'Ghost' => 70,
                         'Ghoul' => 50,
                         'Dragon' => 35,
                         'Vampire' => 50 }
$enemy_class         = { 'Ghost' => Ghost,
                         'Ghoul' => Ghoul,
                         'Dragon' => Dragon,
                         'Vampire' => Vampire }
$exp_levels          = { 0..19 => 1,
                         20..49 => 2,
                         50..89 => 3,
                         90..139 => 4,
                         140..199 => 5 }

# Trap ^C
Signal.trap('INT') do
  puts "\nExitting without saving..."
  sleep(0.5)
  exit
end

# NOTE: Beginning of the game
start
