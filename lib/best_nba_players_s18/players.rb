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

end
