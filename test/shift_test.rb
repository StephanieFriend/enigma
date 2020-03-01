require 'test_helper'
require './lib/shift'
require './lib/enigma'

class ShiftTest < Minitest::Test

  def test_it_exists
    shift = Shift.new

    assert_instance_of Shift, shift
  end

  def test_it_can_transform_key
    enigma = Enigma.new

    enigma.stubs(:encrypt).returns("12345")

    expected =  {:A=>"12", :B=>"23", :C=>"34", :D=>"45"}

    assert_equal expected, Shift.transform_key("12345")
  end

  def test_it_can_transform_date
    enigma = Enigma.new

    DateTime.stubs(:now).returns(DateTime.new(2020, 2, 29))

    expected = {:A=>2, :B=>2, :C=>4, :D=>8}

    assert_equal expected, Shift.transform_date("290220")
  end

  def test_it_can_return_final_shift
    enigma = Enigma.new

    enigma.stubs(:encrypt).returns("12345")
    DateTime.stubs(:now).returns(DateTime.new(2020, 2, 29))

    assert_equal [14, 25, 38, 53], Shift.final_shift_key("12345", "290220")
  end
end