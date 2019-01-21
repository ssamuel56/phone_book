require 'sinatra'
require_relative 'users.rb'
require_relative 'sql.rb'

get '/' do
  erb :landing
end

post '/login' do
  if if_user_exists(params[:username]) && password_verification(retrieve_password(params[:username]), params[:password])
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
  if !if_user_exists(params[:username])
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
  params[:name].each_index do |i|
    add_contacts(
    "2f5121b0-1d92-11e9-bf14-704d7be5c7ab",
    params[:name][i],
    params[:number][i],
    params[:address][i],
    params[:comment][i],
    )
  end
  p get_contacts("2f5121b0-1d92-11e9-bf14-704d7be5c7ab")
end
