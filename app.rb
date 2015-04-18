require 'sinatra'
require 'tilt/erubis'

# require_relative 'routes/init'
# require_relative 'helpers/init'
# require_relative 'models/init'

set :title, "Name of Application"

# index route
get '/' do 
  erb :index
end

# show route
get '/:id' do 
  erb :show
end

# create route
post '/' do 
  redirect '/'
end

# update route
put '/:id' do 
  redirect '/'
end

# destroy route
delete '/:id' do 
  redirect '/'
end
