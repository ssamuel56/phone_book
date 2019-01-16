require 'bcrypt'

def create_hashed_password(password)
  password = BCrypt::Password.create(password)
  return password
end
