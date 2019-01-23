require 'sinatra'
require_relative 'users.rb'
require_relative 'sql.rb'

get '/' do
  erb :landing
end

post '/login' do
  if if_user_exists(params[:username]) && password_verification(retrieve_password(params[:username]), params[:password])
    uuid = user_id(params[:username])
    redirect '/main?uuid=' + uuid
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
  uuid = params[:uuid]
  contacts = get_contacts(uuid).each_slice(4)
  erb :main, locals: {uuid: uuid, contacts: contacts}
end

post '/add' do
  uuid = params[:uuid]
  if params[:name]
    params[:name].each_index do |i|
      unless duplicate_contact(uuid, params[:name][i])
        add_contacts(
          uuid,
          params[:name][i],
          params[:number][i],
          params[:address][i],
          params[:comment][i],
        )
      end
    end
  end
  redirect '/main?uuid=' + uuid
end

post '/delete' do
  uuid = params[:uuid]
  if params[:toDelete]
    params[:toDelete].each do |contact|
      delete_contact(uuid, contact)
    end
  end
  redirect '/main?uuid=' + uuid
end
