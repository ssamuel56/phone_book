require_relative 'sql.rb'
require 'minitest/autorun'

class Test_sql_functions < Minitest::Test

  def test_client_connection
    assert_equal(Mysql2::Client, client().class)
  end

  def test_if_user_exists
    assert_equal(true, if_user_exists("User"))
  end

end
