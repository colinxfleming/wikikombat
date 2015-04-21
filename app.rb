require 'sinatra'
require 'sinatra/activerecord'
require 'tilt/erubis'
require 'json'

db = URI.parse('postgres://user:pass@localhost/sinatra-skeleton')

# require_relative 'routes/init'
# require_relative 'helpers/init'
# require_relative 'models/init'

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)

set :title, "Sinatra-Skeleton"

# index route
get '/' do 
  erb :index
end

# show route
get '/:id' do 
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
