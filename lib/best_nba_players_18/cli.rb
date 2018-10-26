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
    # binding.pry
    system "cls" or system "clear"
    puts "Welcome to my best_nba_players_18 gem","--**player is on ["+"upswing".colorize(:green)+", consistency, "+"decline".colorize(:red)+ "] of his career.**--\n"
    input = ""
    until input == "n" or input == "no"
      opt = -1
      until opt > 0 and opt <= 10
        puts "Invalid input!!! \n" if opt == 0 or opt >= 10
        rows = [
          ["1. List all players by ranking","2. List all players by Age"],
          ["3. List all players by points","4. List all players by rebounds"],
          ["5. List all players by assists","6. List all players by 3pt"],
          ["7. List all players by blocks","8. List all players by free throw"],
          ["9. Group by trend","10. Exit"],
        ]
        table = Terminal::Table.new :title => "Menu", :rows => rows, :style => {:all_separators => true}
        puts table
        print "=> "
        opt = gets.strip.to_i

        system "cls" or system "clear"
      end
      
      break if opt == 10

      if opt != 9
        #sort the @@all
        order =  BestNbaPlayersS18::Players.sort opt

        until input == "n" or input == "no"
          puts "\n What number of players do you want to see? 1-20, 21-40, 41-60, 61-80 or 81-100?  "
            print "=> "
          n_palyer = gets.strip.to_i
          n_palyer = 1 if n_palyer == 0

          #print_players index
          print_players n_palyer, order  if order.class == String
          print_players n_palyer, order[0], order[1]  if order.class == Array

          puts "What player do you want to see more information on?"
            print "=> "
          input = gets.strip.to_i

          #print_player index
          player = BestNbaPlayersS18::Players.find input
          # puts player.name, "\n"
          print_player player

          puts "Do you want to see information about another player? (y/n)"
          print "=> "
          input = gets.strip.downcase
        end
      else
        until input == "n" or input == "no"
          puts "\n What group of trends do you want to see?"," (1- consistent, 2-"+" upswing".colorize(:green)+", 3-"+" decline".colorize(:red)+")"
            print "=> "
          n_trend = gets.strip.to_i
          n_trend = 1 if n_trend  == 0

          choices = ["neutral", "up", "down"]
          by_input = choices[n_trend-1]

          #print_players group by_input
          print_players_group by_input

          puts "What player do you want to see more information on?"
            print "=> "
          input = gets.strip.to_i

          #print_player index
          player = BestNbaPlayersS18::Players.find_group input, by_input
          # puts player.name, "\n"
          print_player player

          puts "Do you want to see information about another player? (y/n)"
          print "=> "
          input = gets.strip.downcase
        end
      end

      puts "Do you want to list all players? (y/n)"
      print "=> "
      input = gets.strip.downcase
      system "cls" or system "clear"
    end

    puts "Goodbye !!"

  end

  def self.print_players(from_number, order = "rank", stats = "")
    
    if stats == ""
      rows = BestNbaPlayersS18::Players.all[from_number-1, 20].each.with_index(from_number).map do |player, index|
        
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

  def self.print_players_group by_input
    arr, rows = [], []
    BestNbaPlayersS18::Players.group(by_input).each.with_index(1) do |player, i|
      # [i, player.name]
      arr.push i, player.name, " "
      if arr.size == 6
        rows << arr
        arr = []
      end
    end
    title = {up: "UPSWING", down: "DECLINE", neutral: "CONSISTENT"}
    puts Terminal::Table.new :title => title[by_input.to_sym], :rows => rows, :style =>{:all_separators => true}
  end

end
