# remember, you can console in irb with: require './app.rb'
require 'sinatra'
require 'sinatra/activerecord'
require 'erubis'
require 'json'
require 'httparty'

# best not to fuss with this part; loads configs, helpers, and models; does all the activerecord config
if settings.development? || settings.test?
  # note that this gem requires tilt 1.4.1 and breaks on tilt 2.0.1. If it screws up try gem uninstall tilt -v 2.0.1
  # uncomment these lines and fill out config.yml if you need secrets in development / aren't deploying to heroku
  require 'sinatra/config_file'
  config_file './config/config.yml'
end
# require everything in models and helpers
['models', 'helpers'].each do |dir|
	Dir.entries("./#{dir}").select { |f| !File.directory? f }.each { |file| require_relative "./#{dir}/#{file}" }
end
set :title, 'Wiki Kombat'

# db stuff
configure :development, :test do 
  set :database, {adapter: 'postgresql', database: settings.dev_db} # make sure to create the db in pg: createdb sinatra-skeleton
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

# ROUTES AND ACTIONS
# index route
get '/' do 
	@requests = Request.order(updated_at: :desc).take(5)
  erb :index
end

# show route
get '/:id' do 
	@requests = Request.find params[:id]
  erb :show
end

# create route
post '/', provides: :json do 
  wiki = params['text_input'].strip.titleize
  if wiki != '' # this should be clientside but serverside is fine for now
    # check if record exists
    a = Request.where(name: wiki.downcase)
    if a.empty?
      # if it doesn't exist, hit wikipedia api and load the result into the db
      input = URI.escape wiki
      wikipedia_url = "http://en.wikipedia.org/w/api.php?format=json&action=query&titles=#{input}&prop=revisions&rvprop=content"
      response = HTTParty.get(wikipedia_url, headers: {"User-Agent" => ENV['user_agent'] ||= settings.user_agent}).parsed_response.to_json
      mk = Request.where(name: 'mortal kombat').first
      a = Request.create  name: wiki.downcase, 
                          length: response.length, 
                          longer_than_mk: response.length > mk.length ? 1 : 0,
                          searches: 1
    else
      # if it already exists, increment and tap the updated_at dt
      a = a.take 
      a.searches += 1
      a.save
    end
    result = a.longer_than_mk? ? "#{a.name.titleize} is longer than the entry for Mortal Kombat." : "#{a.name.titleize} is way less complicated than Mortal Kombat!"
    requests = Request.order(updated_at: :desc).take(5).each { |r| r.name = r.name.titleize }
  	halt 200, {msg: result, roll: requests}.to_json
  else 
    halt 200, {msg: 'Please put something in the form!'}.to_json
  end
end

# close connection to not deplete the pool
after do 
  ActiveRecord::Base.connection.close
end
