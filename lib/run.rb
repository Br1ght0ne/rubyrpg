#!/usr/bin/env ruby

require_relative('modules/text_blocks')
require_relative('modules/action')
require_relative('modules/load_and_save')
include TextBlocks
include Action

# Trap ^C
Signal.trap('INT') do
  puts "\nExitting without saving..."
  sleep(0.5)
  exit
end

def start
  include LoadAndSave
  print_logo
  greet_user
  new_or_load = gets.chomp
  new_or_load == 'l' ? load_game : game_begin
end

# NOTE: Beginning of the game
start

# TODO: Fix issues
# 1. Saving (done!)
# 2. Loading (done!)
# 3. MORE HAND TESTING (done!)
# 4. Write UT, please.
