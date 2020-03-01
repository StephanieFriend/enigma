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

    expected = {:A=>53, :B=>88, :C=>23, :D=>35}

    assert_equal expected, shift.final_shift_key
  end
end