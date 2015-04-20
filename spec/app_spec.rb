require_relative 'spec_helper'

describe 'main app' do 
	it 'should load and return ok' do 
		get '/'
		assert last_response.ok?
	end

	it 'should do something else' do 
		assert true
	end
end
