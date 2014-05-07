# spec/spec_helper.rb
require 'simplecov'
require File.expand_path('../../app/app.rb', __FILE__)
Dir["#{File.dirname(__FILE__)}/support/*.rb"].each {|f| require f}
require 'sinatra'
require 'rack/test'

SimpleCov.start

# setup test environment
ENV['RACK_ENV'] = 'test'
set :environment, :test
set :run, false
set :raise_errors, false
set :logging, false

def app
  Sinatra::Application
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.color_enabled = true
  config.treat_symbols_as_metadata_keys_with_true_values = true
end