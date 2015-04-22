# remember, you can console in irb with: require './app.rb'

require 'sinatra'
require 'sinatra/activerecord'
require 'tilt/erubis'
require 'json'

# require everything in models and helpers
['models', 'helpers'].each do |dir|
	Dir.entries("./#{dir}").select { |f| !File.directory? f }.each { |file| require_relative "./#{dir}/#{file}" }
end

set :title, "Sinatra-Skeleton"
set :database, {adapter: 'postgresql', database: 'sinatra-skeleton'} # make sure to create the db in pg: createdb sinatra-skeleton

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
	# puts params	
	halt 200, {yolo: "#{params[:text_input]}"}.to_json
end

# update route
put '/:id' do 
	# puts "update route"
  redirect '/'
end

# destroy route
delete '/:id' do 
	# puts "Delete route"
  redirect '/'
end
