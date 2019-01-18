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

def add_a_user()

client.query("INSERT INTO users (username) VALUES ('Samuel')")

end
