require_relative 'users.rb'
require 'minitest/autorun'

class Test_user_file < Minitest::Test

  def test_1_to_1
    assert_equal(1, 1)
  end

  def test_bcrypt_check_password_encrypts
    password = "Generic Pass"
    assert_equal(BCrypt::Password, create_hashed_password(password).class)
  end

  def test_bcrypt_password_matches_hash
    password = "Generic Pass"
    hashed_password = create_hashed_password(password)
    assert_equal(true, BCrypt::Password.new(hashed_password) == password)
  end

end
