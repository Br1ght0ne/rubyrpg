module TextBlocks
  # rubocop:disable Metrics/MethodLength
  def print_logo
    puts "\n"\
         "      #######     \n"\
         "     #&&&&&&&#    \n"\
         "      #&&&&&#     \n"\
         "       #&&&#      \n"\
         "        #&#       \n"\
         "         #        \n"\
         "                  \n"\
         "  #### #### ####  \n"\
         "  #  # #  # #     \n"\
         "  #### #### # ##  \n"\
         "  # #  #    #  #  \n"\
         "  #  # #    ####  \n"\
         "\n"
  end

  def greet_user
    puts "Welcome to RubyRPG 0.8.0 Alpha!\n"
    sleep(1.5)
    puts "\ns - start new adventure | l - load existing character"
  end
end
