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

  def test_retrieve_password
    assert_equal(String, retrieve_password("User").class)
  end

  def test_get_contacts
    assert_equal(Array, get_contacts("2f5121b0-1d92-11e9-bf14-704d7be5c7ab").class)
  end

  def test_for_duplicate_contact
    assert_equal(
      false,
      duplicate_contact("2f5121b0-1d92-11e9-bf14-704d7be5c7ab", "Samuel")
    )
  end

  def test_for_update_contact
    uuid = "8f52eac4-2040-11e9-bf14-704d7be5c7ab"
    contact = ["sam", "1234567890", "162 Doggo st", "Is me"]
    assert_nil(edit_contact(uuid, contact))
  end

end
