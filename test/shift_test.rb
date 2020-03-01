require 'test_helper'
require './lib/shift'
require './lib/key'
require './lib/dated'

class ShiftTest < Minitest::Test

  def test_it_exists
    shift = Shift.new

    assert_instance_of Shift, shift
  end

  def test_it_can_return_final_shift
    shift = Shift.new
    dated = Dated.new

    Key.stubs(:generate_random_key).returns("12345")
    DateTime.stubs(:now).returns(DateTime.new(2020, 2, 29))

    assert_equal [14, 25, 38, 53], shift.final_shift_key
  end
end