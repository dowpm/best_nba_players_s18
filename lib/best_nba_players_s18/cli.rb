class BestNbaPlayersS18::CLI
    URL = "https://www.washingtonpost.com/graphics/2017/sports/nba-top-100-players-2017/?noredirect=on&utm_term=.adcc13ae7e38"
    COLORIER = ->(player){
      color = ""
      color = :green if player.trend == "up"
      color = :red if player.trend == "down"
      color
    }

  def self.run
    collections = BestNbaPlayersS18::Scraper.scrape_page(URL)
    BestNbaPlayersS18::Players.create_players_from_collection collections
  end

  def self.start
    run
    input = ""
    until input == "n" or input == "no"
      opt = -1
      until opt > 0 and opt <= 9
        puts "Invalid input!!! \n" if opt == 0 or opt >= 9
        puts "Choose an option", "1. List all players by ranking", "2. List all players by Age"
        puts "3. List all players by points", "4. List all players by rebounds", "5. List all players by assists"
        puts "6. List all players by 3pt", "7. List all players by blocks", "8. List all players by free throw"
        puts "9. Exit"
        print "=> "
        opt = gets.strip.to_i

        system "cls" or system "clear"
      end
      
      break if opt == 9
      #sort the @@all
      order =  BestNbaPlayersS18::Players.sort opt

      until input == "n" or input == "no"
        puts "\n What number of players do you want to see? 1-20, 21-40, 41-60, 61-80 or 81-100?  "
        n_palyer = gets.strip.to_i

        #print_players index
        print_players n_palyer, order  if order.class == String
        print_players n_palyer, order[0], order[1]  if order.class == Array

        puts "What player do you want to see more information on?"
        input = gets.strip.to_i

        #print_player index
        player = BestNbaPlayersS18::Players.find input
        # puts player.name, "\n"
        print_player player

        puts "Do you want to see information about another player? (y/n)"
        input = gets.strip.downcase
      end

      puts "Do you want to list all players? (y/n)"
      input = gets.strip.downcase
    end

    puts "Goodbye !!"

  end

  def self.print_players(from_number, order = "rank", stats = "")
    
    if stats == ""
      rows = BestNbaPlayersS18::Players.all[from_number-1, 20].each.with_index(from_number).map do |player, index|
        # colorier.(player)
        [index, player.name.colorize(COLORIER.(player)), "#{order}:#{player.send(order)}"]
      end
    else
      rows = BestNbaPlayersS18::Players.all[from_number-1, 20].each.with_index(from_number).map do |player, index|
        
        [index, player.name.colorize(COLORIER.(player)), "#{stats} : #{player.send(order)[stats.to_sym]}"]
      end
    end

    table = Terminal::Table.new :title => "Players #{from_number} - #{from_number+19}", :rows => rows, :style => {:all_separators => true}
    puts table
  end

  def self.print_player player
    table = Terminal::Table.new :title => "#{player.name}", :rows => [
      ["Age", player.statistics[:AGE].colorize(COLORIER.(player))],
      ["Position", player.position.colorize(COLORIER.(player))],
      ["Team", player.team.colorize(COLORIER.(player))],
      ["Rank", player.rank.to_s.colorize(COLORIER.(player))],
      ["PPG", player.statistics[:PPG].to_s.colorize(COLORIER.(player))],
      ["RPG", player.statistics[:RPG].to_s.colorize(COLORIER.(player))],
      ["APG", player.statistics[:APG].to_s.colorize(COLORIER.(player))],
      ["BLK", player.statistics[:BLK].to_s.colorize(COLORIER.(player))],
      ["FT", player.statistics[:FT].to_s.colorize(COLORIER.(player))],
      ["Steal", player.statistics[:STL].to_s.colorize(COLORIER.(player))],
      ["FG", player.statistics[:FG].to_s.colorize(COLORIER.(player))],
      ["3PT", player.statistics[:THREEPT].to_s.colorize(COLORIER.(player))]
    ]
    puts table
  end

end
