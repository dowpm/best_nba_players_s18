class BestNbaPlayersS18::CLI
    URL = "https://www.washingtonpost.com/graphics/2017/sports/nba-top-100-players-2017/?noredirect=on&utm_term=.adcc13ae7e38"

  def self.run
    collections = BestNbaPlayersS18::Scraper.scrape_page(URL)
    BestNbaPlayersS18::Players.create_players_from_collection collections
  end

  def self.start
    input = ""
    until input == "n" or input == "no"
      input = -1
      until input > 0 and input < 5
        puts "Invalid input!!! \n" if input == 0 or input > 5
        puts "Choose an option", "1. List all players by ranking", "2. List all players by Age"
        puts "3. List all players by points", "4. List all players by 3pt", "5. List all players by free throw"
        print "=> "
        input = gets.strip.to_i

        system "cls" or system "clear"
      end
      #sort the @@all

      until input == "n" or input == "no"
        puts "\n What number of players do you want to see? 1-20, 21-40, 41-60, 61-80 or 81-100?  "
        input = gets.strip.to_i

        #print_players index

        puts "What player do you want to see more information on?"
        input = gets.strip.to_i

        #print_player index

        puts "Do you want to see information about another player? (y/n)"
        input = gets.strip.downcase
      end

      puts "Do you want to list all players? (y/n)"
      input = gets.strip.downcase
      # start if input == "y" or input == "yes"
    end

    puts "Goodbye !!"

  end

  def self.print_players

  end

end
