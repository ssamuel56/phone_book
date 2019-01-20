require 'mysql2'
load 'local_env.rb'

def client
  Mysql2::Client.new(
    :host => ENV['host'],
    :username => ENV['username'],
    :password => ENV['password'],
    :database => ENV['db'],
    :port => ENV['port']
  )
end

def add_a_user(username, password)
  if_user_exists = client.query("SELECT username FROM users WHERE users.username = '#{username}'")

  if if_user_exists.count == 0
    client.query("INSERT INTO users (uuid, username, password) VALUES (UUID(), '#{username}', '#{password}')")
    return true
  else
    return false
  end
end
