require_relative 'sql.rb'
require 'minitest/autorun'

class Test_sql_functions < Minitest::Test

  def test_client_connection
    assert_equal(Mysql2::Client, client().class)
  end

end
