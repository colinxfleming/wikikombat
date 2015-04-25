# remember, you can console in irb with: require './app.rb'

require 'sinatra'
require 'sinatra/activerecord'
require 'erubis'
require 'json'
require 'httparty'

# require 'sinatra/config_file' # uncomment these lines and fill out secrets.yml if you need secrets
# config_file './config/secrets.yml'

# require everything in models and helpers
['models', 'helpers'].each do |dir|
	Dir.entries("./#{dir}").select { |f| !File.directory? f }.each { |file| require_relative "./#{dir}/#{file}" }
end

set :title, "Sinatra-Skeleton"

# db stuff
configure :development do 
  set :database, {adapter: 'postgresql', database: 'sinatra-skeleton'} # make sure to create the db in pg: createdb sinatra-skeleton
end
configure :production do
 db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/mydb')
 ActiveRecord::Base.establish_connection(
   :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
   :host     => db.host,
   :username => db.user,
   :password => db.password,
   :database => db.path[1..-1],
   :encoding => 'utf8'
 )
end

# ROUTES
# index route
get '/' do 
	@requests = Request.last(5).order(id: :desc)
  erb :index
end

# show route
get '/:id' do 
	@requests = Request.find params[:id]
  erb :show
end

# create route
post '/', provides: :json do 
  if params['text_input'].strip != ''
    # take input and get wikipedia page for that thing
    # not fancy enough to handle multiple entries for something with the same name
    input = URI.escape params['text_input']
    response = HTTParty.get("http://en.wikipedia.org/w/api.php?format=json&action=query&titles=#{input}&prop=revisions&rvprop=content").parsed_response.to_json

    mk = Request.where name: 'Mortal Kombat'

    a = Request.create  name: params['text_input'], 
                    length: response.length, 
                    longer_than_mk: response.length > mk.length ? 1 : 0

    result = a.longer_than_mk? ? "#{a.name} is longer than the entry for Mortal Kombat." : "#{a.name} is way less complicated than Mortal Kombat!"

  	halt 200, {msg: result}.to_json
  else 
    halt 200, {msg: 'Please put something in the form!'}.to_json
  end
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

# close connection to not deplete the pool
after do 
  ActiveRecord::Base.connection.close
end