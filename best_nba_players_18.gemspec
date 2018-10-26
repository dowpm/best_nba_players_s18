
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "best_nba_players_18/version"

Gem::Specification.new do |spec|
  spec.name          = "best_nba_players_18"
  spec.version       = BestNbaPlayersS18::VERSION
  spec.authors       = ["'Mac Dowell Prosper'"]
  spec.email         = ["'macdowell@noukod.com'"]

  spec.summary       = "This gem is for showing the top 100 nba players (season 17-18)"
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/dowpm/best_nba_players_18"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "terminal-table"
  spec.add_development_dependency "colorize"
end