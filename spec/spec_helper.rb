require 'spec_helper_lite'

# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"
require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'rspec/rails'
require "database_cleaner"
require 'rspec/autorun'
require 'dataset'
require 'dataset/extensions/rspec'

ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')
Dataset::Resolver.default = Dataset::DirectoryResolver.new("#{ENGINE_RAILS_ROOT}/spec/datasets")

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each {|f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = false
    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
    end
    config.before(:each) do
      DatabaseCleaner.start
    end
    config.after(:each) do
      DatabaseCleaner.clean
    end
end