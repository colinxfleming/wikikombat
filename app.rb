# remember, you can console in irb with: require './app.rb'

require 'sinatra'
require 'sinatra/activerecord'
require 'erubis'
require 'json'

# require everything in models and helpers
['models', 'helpers'].each do |dir|
	Dir.entries("./#{dir}").select { |f| !File.directory? f }.each { |file| require_relative "./#{dir}/#{file}" }
end

set :title, "Sinatra-Skeleton"

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
	# puts params['text_input']	
  # guide: http://www.mediawiki.org/wiki/API:Main_page
  # 'http://en.wikipedia.org/w/api.php?format=json&action=query&titles=Main%20Page&prop=revisions&rvprop=content'
  # access via a.parsed_response['query']['pages'][???????]
  # Request.create name: params['text_input']
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

after do 
  ActiveRecord::Base.connection.close
end