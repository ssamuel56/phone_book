require 'mysql2'
require_relative 'users.rb'
load 'local_env.rb' if File.exist?('local_env.rb')

def client
  Mysql2::Client.new(
    :host => ENV['host'],
    :username => ENV['username'],
    :password => ENV['password'],
    :database => ENV['db'],
    :port => ENV['port']
  )
end

def if_user_exists(username)
  if_user_exists = client.query(
    "SELECT username FROM users WHERE users.username = '#{username}'"
  )
  return if_user_exists.count > 0
end

def add_a_user(username, password)
  password = create_hashed_password(password)
  if !if_user_exists(username)
    client.query(
      "INSERT INTO users (uuid, username, password)
      VALUES (UUID(), '#{username}', '#{password}')"
    )
  end
end

def user_id(username)
  id = client.query(
    "SELECT uuid FROM users WHERE users.username = '#{username}'"
  )
  id.each do |i|
    return i["uuid"].to_s
  end
end

def verify_uuid(uuid)
  uuid = client.query(
    "SELECT *
    FROM users
    WHERE uuid = '#{uuid}'"
  )
  return uuid.count > 0
end

def retrieve_password(username)
  password = client.query(
    "SELECT password FROM users WHERE users.username = '#{username}'"
  )
  password.each do |pass|
    return pass["password"].to_s
  end
end

def get_contacts(user_id)
  contacts = client.query(
    "SELECT * FROM contacts WHERE uuid = '#{user_id}'"
  )
  ary = Array.new
  contacts.each do |contact|
    ary << contact["name"]
    ary << contact["number"]
    ary << contact["address"]
    ary << contact["comment"]
  end
  return ary
end

def duplicate_contact(user_id, name)
  user = client.query(
    "SELECT name FROM contacts
    WHERE contacts.name = '#{name}'
    AND contacts.uuid = '#{user_id}'"
  )
  return user.count > 0
end

def add_contacts(user_id, name, number, address, comment)
  client.query(
    "INSERT INTO contacts (uuid, name, number, address, comment)
    VALUES ('#{user_id}', '#{name}', '#{number}', '#{address}', '#{comment}')"
  )
end

def edit_contact(uuid, contact)
  client.query(
    "UPDATE contacts
    SET name = '#{contact[1]}', number = '#{contact[2]}',
    address = '#{contact[3]}', comment = '#{contact[4]}'
    WHERE uuid = '#{uuid}' AND contacts.name = '#{contact[0]}'"
  )
end

def delete_contact(user_id, name)
  client.query(
    "DELETE FROM contacts
    WHERE contacts.name = '#{name}'
    AND contacts.uuid = '#{user_id}'"
  )
end
