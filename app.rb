require 'sinatra'

get '/' do
  erb :landing
end


post '/login' do
  redirect '/main'
end


get '/main' do
  erb :main
end
