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
  usr_name = params[:username]
  pass = params[:password]
  if !if_user_exists(usr_name) && usr_name.match(/^a-zA-Z0-9/) && pass.match(/^a-zA-Z0-9/)
    add_a_user(usr_name, pass)
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
  names = params[:name]
  if params[:name]
    names.each_index do |i|
      unless duplicate_contact(uuid, names[i])
        add_contacts(
          uuid,
          names[i].gsub(/[^a-zA-Z0-9\s]/, ''),
          names[i].gsub(/[^a-zA-Z0-9-]/, ''),
          names[i].gsub(/[^a-zA-Z0-9\s]/, ''),
          names[i].gsub(/[^a-zA-Z0-9\s]/, ''),
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
