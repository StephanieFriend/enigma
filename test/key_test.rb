require 'test_helper'
require './lib/key'

class KeyTest < Minitest::Test

  def test_it_exists
    key = Key.new

    assert_instance_of Key, key
  end

  def test_it_can_generate_random_key
    key = Key.new

    Key.stubs(:generate_random_key).returns(01234)
    assert_equal 01234, key.generate_random_key
  end

  def test_it_can_create_five_digit_with_user_input
    key = Key.new

    assert_equal 00345, key.key_input
  end
end