ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!
require 'rack/test'
require_relative '../app'

include Rack::Test::Methods

def app
  Sinatra::Application
end
