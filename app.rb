require 'sinatra'
require_relative 'users.rb'

get '/' do
  erb :landing
end


post '/login' do
  redirect '/main'
end


get '/main' do
  erb :main
end
