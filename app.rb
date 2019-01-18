require 'sinatra'
require_relative 'users.rb'
require_relative 'sql.rb'

get '/' do
  erb :landing
end

post '/login' do
  password_hash = "$2a$10$VWw.FNQ5OO7mYxSlzbisVeexqgi4F5onOjpAAWr66ARyxuZDwRvBu"
  temp_user_check = "User" == params[:username]
  temp_user_pass_check = password_verification(password_hash, params[:password])

  if temp_user_check && temp_user_pass_check
    redirect '/main'
  else
    redirect '/failed'
  end
end

get '/failed' do
  erb :failed
end

get '/create' do
  valid = params[:valid] ? false : true
  erb :create, locals: {valid: valid}
end

post '/create' do
  if add_a_user(params[:username], params[:password])
    add_a_user(params[:username], params[:password])
    redirect '/'
  else
    redirect '/create?valid=' + "false"
  end
end

get '/main' do
  erb :main
end

post '/add' do
  p params
end
