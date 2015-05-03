require_relative 'spec_helper'

class AppTest < ActiveSupport::TestCase
	describe 'main app' do 
		it 'should run the stupid test suite' do 
			assert true
		end

		it 'should load the root and return ok' do 
			get '/'
			assert last_response.ok?
		end

		it 'should load the show route' do 
			get '/1'
			assert last_response.ok?
		end

		it 'should accept post requests' do 
			post '/', params = {text_input: 'goat'}
			assert last_response.ok?
		end

		it 'should return some real nice json' do 
			post '/', params = {text_input: 'goat'}
			assert last_response.ok?
			post '/', params = {text_input: 'United States Constitution'}
			assert last_response.ok?
		end

		# it 'should have a working update route' do
		# 	put '/1'
		# 	assert true
		# end

		# it 'should have a working delete route' do 
		# 	delete '/1'
		# 	assert true
		# end
	end
end

class ModelTest < ActiveSupport::TestCase
	describe 'datamodels' do 
		timestamp = Time.now.strftime('%s')

		it 'should create a new entry for new requests' do 
			assert_difference 'Request.count', 1 do 
				Request.create name: timestamp, length: 100, searches: 1, longer_than_mk: 1
			end
		end

		it 'should not create a new entry for existing requests' do 
			assert_no_difference 'Request.count', 0 do 
				# already created by the test above
				post "/?text_input=#{timestamp}" # dirty but it works!
			end
		end

		it 'should increment searches' do 
			assert_difference "Request.where(name: #{timestamp}).first.searches", 1 do 
				post "/?text_input=#{timestamp}"
			end
		end
	end
end