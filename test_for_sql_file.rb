require_relative 'sql.rb'
require 'minitest/autorun'

class Test_sql_functions < Minitest::Test

  def test_client_connection
    assert_equal(Mysql2::Client, client().class)
  end

  def test_if_user_exists
    assert_equal(true, if_user_exists("User"))
    assert_equal(false, if_user_exists("B"))
  end

  def test_user_id
    assert_equal(String, user_id("User").class)
  end

end
