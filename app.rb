require 'sinatra'

# require_relative 'routes/init'
# require_relative 'helpers/init'
# require_relative 'models/init'


get '/' do 
  # index route
  @title = 'Yolorita | Index'
  erb :index
end

get '/:id' do 
  # show route
  @title = 'Yolorita | Show'
  erb :show
end

post '/' do 
  # create route
  redirect '/'
end

put '/:id' do 
  # edit route
  redirect '/'
end

delete '/:id' do 
  # destroy route
  redirect '/'
end
