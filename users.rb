require 'bcrypt'

def create_hashed_password(password)
  password = BCrypt::Password.create(password)
  return password
end

def password_verification(hashed_password, password)
  return BCrypt::Password.new(hashed_password) == password
end
