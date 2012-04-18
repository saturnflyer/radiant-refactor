$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "radiant/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "radiant"
  s.version     = Radiant::VERSION
  s.authors     = ["Radiant CMS dev team"]
  s.email       = ["radiant@radiantcms.org"]
  s.homepage    = "http://radiantcms.org"
  s.summary     = "A no-fluff content management system designed for small teams."
  s.description = "Radiant is a simple and powerful publishing system designed for small teams.
It is built with Rails and is similar to Textpattern or MovableType, but is
a general purpose content managment system--not merely a blogging engine."

  ignores = File.read('.gitignore').split("\n").inject([]) {|a,p| a + Dir[p] }
  s.files = Dir['**/*','.gitignore', 'public/.htaccess', 'log/.keep', 'vendor/extensions/.keep'] - ignores
  
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.2"
  s.add_dependency "radius"
  s.add_dependency "ancestry"
  s.add_dependency "will_paginate"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "database_cleaner"
end
