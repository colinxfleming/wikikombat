ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!
require 'rack/test'

class ActiveSupport::TestCase
	require_relative '../app'
	include Rack::Test::Methods
	include ActiveSupport::Testing::Assertions
	def app
	  Sinatra::Application
	end
end