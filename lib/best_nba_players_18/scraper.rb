class BestNbaPlayersS18::Scraper

    def self.scrape_page url
        nokogiri_url = Nokogiri::HTML(open(url))
        players_neutral_nokogiri = nokogiri_url.search(".player-container.trend-neutral div.player-info-inner")
        players_up_nokogiri = nokogiri_url.search(".player-container.trend-up div.player-info-inner")
        players_down_nokogiri = nokogiri_url.search(".player-container.trend-down div.player-info-inner")
    
        players_neutral = players_neutral_nokogiri.map do |p|
            stats = p.css("ul.player-info-barns li").text.gsub("\s","").split("\n\n")
            {
                trend: "neutral",
                rank: p.css(".player-info-name").children[1].text.strip.to_i,
                name: p.css(".player-info-name").children[2].text.strip,
                position: p.css("p")[0].text.split(", ")[0],
                team: p.css("p")[0].text.split(", ")[1],
                info: p.css("p")[1].text,
                statistics: {
                    PPG: stats[0].split("\n")[-1].to_f,
                    RPG: stats[1].split("\n")[-1].to_f,
                    APG: stats[3].split("\n")[-1].to_f,
                    AGE: stats[5].split("\n")[-1],
                    STL: stats[6].split("\n")[-1].to_f,
                    FG: stats[7].split("\n")[-1].to_f,
                    FT: stats[8].split("\n")[-1].to_f,
                    THREEPT: stats[9].split("\n")[-1].to_f,
                    BLK: stats[10].split("\n")[-1].to_f
                }
                
            }
        end
        players_up = players_up_nokogiri.map do |p|
            stats = p.css("ul.player-info-barns li").text.gsub("\s","").split("\n\n")
            {
                trend: "up",
                rank: p.css(".player-info-name").children[1].text.strip.to_i,
                name: p.css(".player-info-name").children[2].text.strip,
                position: p.css("p")[0].text.split(", ")[0],
                team: p.css("p")[0].text.split(", ")[1],
                info: p.css("p")[1].text,
                statistics: {
                    PPG: stats[0].split("\n")[-1].to_f,
                    RPG: stats[1].split("\n")[-1].to_f,
                    APG: stats[3].split("\n")[-1].to_f,
                    AGE: stats[5].split("\n")[-1],
                    STL: stats[6].split("\n")[-1].to_f,
                    FG: stats[7].split("\n")[-1].to_f,
                    FT: stats[8].split("\n")[-1].to_f,
                    THREEPT: stats[9].split("\n")[-1].to_f,
                    BLK: stats[10].split("\n")[-1].to_f
                }
                
            }
        end
        players_down = players_down_nokogiri.map do |p|
            stats = p.css("ul.player-info-barns li").text.gsub("\s","").split("\n\n")
            {
                trend: "down",
                rank: p.css(".player-info-name").children[1].text.strip.to_i,
                name: p.css(".player-info-name").children[2].text.strip,
                position: p.css("p")[0].text.split(", ")[0],
                team: p.css("p")[0].text.split(", ")[1],
                info: p.css("p")[1].text,
                statistics: {
                    PPG: stats[0].split("\n")[-1].to_f,
                    RPG: stats[1].split("\n")[-1].to_f,
                    APG: stats[3].split("\n")[-1].to_f,
                    AGE: stats[5].split("\n")[-1],
                    STL: stats[6].split("\n")[-1].to_f,
                    FG: stats[7].split("\n")[-1].to_f,
                    FT: stats[8].split("\n")[-1].to_f,
                    THREEPT: stats[9].split("\n")[-1].to_f,
                    BLK: stats[10].split("\n")[-1].to_f
                }
                
            }
        end
    
        #   binding.pry
        return players_neutral, players_up, players_down
    end
  
  end