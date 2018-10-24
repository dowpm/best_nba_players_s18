class BestNbaPlayersS18::Scraper

    def self.scrape_page url
      nokogiri_url = Nokogiri::HTML(open(url))
      players_neutral_nokogiri = nokogiri_url.search(".player-container.trend-neutral div.player-info-inner")
  
      player_name = players_neutral_nokogiri.css(".player-info-name").children[2].text.strip
      player_rank = players_neutral_nokogiri.css(".player-info-name").children[1].text.strip
      player_position, player_team = players_neutral_nokogiri.css(".player-info-team-and-positon").text.split(",")
  
      binding.pry
    end
  
  end