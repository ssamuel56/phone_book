require 'sinatra'
require_relative 'users.rb'
require_relative 'sql.rb'

get '/' do
  acct_created = params[:created] ? true : false
  erb :landing, locals: {created: acct_created}
end

post '/login' do
  usr_name = params[:username]
  pass = params[:password]
  if if_user_exists(usr_name) && password_verification(retrieve_password(usr_name), pass)
    uuid = user_id(usr_name)
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
  if !if_user_exists(usr_name) && /\A[A-Za-z0-9]+\Z/ === usr_name && /\A[A-Za-z0-9]+\Z/ === pass
    add_a_user(usr_name, pass)
    redirect '/?created=' + "true"
  else
    redirect '/create?valid=' + "false"
  end
end

get '/main' do
  uuid = params[:uuid]
  if verify_uuid(uuid)
    contacts = get_contacts(uuid).each_slice(4)
    erb :main, locals: {uuid: uuid, contacts: contacts}
  else
    redirect '/'
  end
end

post '/add' do
  uuid = params[:uuid]
  names = params[:name]
  if names && verify_uuid(uuid)
    names.each_index do |i|
      unless duplicate_contact(uuid, names[i])
        add_contacts(
          uuid,
          names[i].gsub(/[^a-zA-Z0-9\s]/, ''),
          params[:number][i].gsub(/[^a-zA-Z0-9-]/, ''),
          params[:address][i].gsub(/[^a-zA-Z0-9\s]/, ''),
          params[:comment][i].gsub(/[^a-zA-Z0-9\s]/, ''),
        )
      end
    end
  end
  redirect '/main?uuid=' + uuid
end

post '/edit' do
  contact = params[:toChange].each {|x| x.gsub(/[^a-zA-Z0-9-]/, '')}
  uuid = params[:uuid]
  if (contact[0] == contact[1]) || (!duplicate_contact(uuid, contact[1]))
    edit_contact(uuid, contact)
  end
  redirect '/main?uuid=' + uuid
end

post '/delete' do
  uuid = params[:uuid]
  to_del = params[:toDelete]
  if to_del
    to_del.each do |contact|
      delete_contact(uuid, contact)
    end
  end
  redirect '/main?uuid=' + uuid
end
