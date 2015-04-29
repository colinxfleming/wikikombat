require_relative 'spec_helper'

class AppTest < ActiveSupport::TestCase
	describe 'main app' do 
		# it 'should run the stupid test suite' do 
		# 	assert true
		# end

		# it 'should load the root and return ok' do 
		# 	get '/'
		# 	assert last_response.ok?
		# end

		# it 'should load the show route' do 
		# 	get '/1'
		# 	assert last_response.ok?
		# end

		# it 'should accept post requests' do 
		# 	post '/', params = {text_input: 'goat'}
		# 	assert last_response.ok?
		# end

		# it 'should return some real nice json' do 
		# 	post '/', params = {text_input: 'goat'}
		# 	assert last_response.ok?
		# 	assert_equal last_response.body, {msg: 'Goat is way less complicated than Mortal Kombat!'}.to_json
		# 	post '/', params = {text_input: 'United States Constitution'}
		# 	assert last_response.ok?
		# 	assert_equal last_response.body, {msg: 'United States Constitution is longer than the entry for Mortal Kombat.'}.to_json
		# end

		# it 'should have a working update route' do
		# 	put '/1'
		# 	assert true
		# end

		# it 'should have a working delete route' do 
		# 	delete '/1'
		# 	assert true
		# end
	end

	describe 'datamodels' do 
		it 'should create a new entry for new requests' do 
			assert_difference 'Request.count', 1 do 
				Request.create name: 'rake test', length: 100, longer_than_mk: 1
			end
		end

		it 'should not create a new entry for existing requests' do 
			assert_no_difference 'Request.count', 0 do 
				post '/', params: {text_input: 'rake test'} 
			end
		end

		it 'should set the longer_than_mk boolean properly' do 
		end

		# manual db cleanup
		Request.destroy_all name: 'rake test'
	end
end