require_relative 'users.rb'
require 'minitest/autorun'

class Test_user_file < Minitest::Test

  def test_1_to_1
    assert_equal(1, 1)
  end

  def test_bcrypt_check_password_encrypts
    password = "Generic Pass"
    assert_equal(String, check_user_password(password))
  end

end
