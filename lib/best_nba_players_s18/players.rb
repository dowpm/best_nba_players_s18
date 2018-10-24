class BestNbaPlayersS18::Players
    attr_accessor :trend, :name, :team, :position, :statistics, :rank, :info
    @@all = []

    def self.all
        @@all
    end

    def initialize infos_hash
        infos_hash.each do |info, value|
            self.send("#{info}=",value)
        end
        @@all << self
    end

    def self.create_players_from_collection collection
        collection.each do |players|
            players.each {|infos_hash| new(infos_hash) }
        end
    end

    def self.find input
        all[input-1]
    end

    def self.sort(input = "rank")
        case input
        when "rank"
            all.sort! do |player1, player2|
                player1.rank <=> player2.rank
            end
        when "name"
            all.sort! do |player1, player2|
                player1.name <=> player2.name
            end
        when "age"
            all.sort! do |player1, player2|
                player1.statistics[:AGE] <=> player2.statistics[:AGE]
            end
        when "3pt"
            all.sort! do |player1, player2|
                player1.statistics[:THREEPT] <=> player2.statistics[:THREEPT]
            end
        when "ft"
            all.sort! do |player1, player2|
                player1.statistics[:FT] <=> player2.statistics[:FT]
            end
        end
    end

end
