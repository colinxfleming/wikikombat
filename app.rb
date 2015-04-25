# remember, you can console in irb with: require './app.rb'

require 'sinatra'
require 'sinatra/activerecord'
require 'erubis'
require 'json'
require 'httparty'

require './config/environments'

# require everything in models and helpers
['models', 'helpers'].each do |dir|
	Dir.entries("./#{dir}").select { |f| !File.directory? f }.each { |file| require_relative "./#{dir}/#{file}" }
end

# require "sinatra/config_file"
# config_file 'path/to/config.yml'

set :title, "Sinatra-Skeleton"

# index route
get '/' do 
	@requests = Request.last 5
  erb :index
end

# show route
get '/:id' do 
	@requests = Request.find params[:id]
  erb :show
end

# create route
post '/', provides: :json do 
  # take input and get wikipedia page for that thing
  # not fancy enough to handle multiple entries for something with the same name
  input = URI.escape params['text_input']
  response = HTTParty.get("http://en.wikipedia.org/w/api.php?format=json&action=query&titles=#{input}&prop=revisions&rvprop=content").parsed_response.to_json

  mk = Request.find 1

  Request.create  name: params['text_input'], 
                  length: response.length, 
                  longer_than_mk: response.length > mk.length? ? 1 : 0

	halt 200, {yolo: "#{params[:text_input]}"}.to_json
end

# update route
# put '/:id' do 
	# puts "update route"
  # redirect '/'
# end

# destroy route
# delete '/:id' do 
	# puts "Delete route"
  # redirect '/'
# end

after do 
  ActiveRecord::Base.connection.close
end