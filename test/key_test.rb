require 'test_helper'
require './lib/key'

class KeyTest < Minitest::Test

  def test_it_exists
    key = Key.new

    assert_instance_of Key, key
  end

  def test_it_can_generate_random_key
    key = Key.new

    assert_instance_of String, key.generate_random_key
    assert_equal 5, key.generate_random_key.length
  end

  def test_it_can_create_five_digit_with_user_input
    key = Key.new

    assert_equal "00345", key.key_input(345)
  end

  def test_it_can_transform_key
    key = Key.new

    key.stubs(:generate_random_key).returns("12345")

    expected = {:A=>"12", :B=>"23", :C=>"34", :D=>"45"}

    assert_equal expected, key.transform_key("12345")
  end
end