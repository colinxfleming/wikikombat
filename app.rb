# remember, you can console in irb with: require './app.rb'

require 'sinatra'
require 'sinatra/activerecord'
require 'erubis'
require 'json'
require 'httparty'

# note that this gem requires tilt 1.4.1 and breaks on tilt 2.0.1. If it screws up try gem uninstall tilt -v 2.0.1
require 'sinatra/config_file' # uncomment these lines and fill out config.yml if you need secrets
config_file './config/config.yml'

# require everything in models and helpers
['models', 'helpers'].each do |dir|
	Dir.entries("./#{dir}").select { |f| !File.directory? f }.each { |file| require_relative "./#{dir}/#{file}" }
end

set :title, settings.title

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
	@requests = Request.last(5).reverse
  erb :index
end

# show route
get '/:id' do 
	@requests = Request.find params[:id]
  erb :show
end

# create route
post '/', provides: :json do 
  #  room for improvement: checking against the db first
  # lowercasing everything
  #  enforcing uniqueness db side


  if params['text_input'].strip != ''
    # take input and get wikipedia page for that thing
    # not fancy enough to handle multiple entries for something with the same name

    wiki = params['text_input'].strip.downcase

    if Request.where(name: wiki).empty?
      input = URI.escape params['text_input']
      wikipedia_url = "http://en.wikipedia.org/w/api.php?format=json&action=query&titles=#{input}&prop=revisions&rvprop=content"

      response = HTTParty.get(wikipedia_url, headers: {"User-Agent" => settings.user_agent}).parsed_response.to_json

      mk = Request.where(name: 'mortal kombat').first

      a = Request.create  name: wiki, 
                          length: response.length, 
                          longer_than_mk: response.length > mk.length ? 1 : 0,
                          searches: 1
    else
      a = Request.where name: wiki
      a.searches += 1
      a.save
    end

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