require "best_nba_players_s18/version"

require 'pry'
require 'nokogiri'
require 'open-uri'
require 'terminal-table'
require 'colorize'

module BestNbaPlayersS18
  # Your code goes here...
  require 'best_nba_players_s18/cli'
  require 'best_nba_players_s18/players'
  require 'best_nba_players_s18/scraper'
end
