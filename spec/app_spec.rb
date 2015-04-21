require_relative 'spec_helper'

describe 'main app' do 
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
		assert_equal last_response.body, {yolo: 'goat'}.to_json
		post '/', params = {text_input: 'United States Constitution'}
		assert last_response.ok?
		assert_equal last_response.body, {yolo: 'United States Constitution'}.to_json
	end

	it 'should have a working update route' do
		put '/1'
		assert true
	end

	it 'should have a working delete route' do 
		delete '/1'
		assert true
	end

	it 'should do something else' do 
		assert true
	end
end
