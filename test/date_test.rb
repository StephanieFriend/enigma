require 'test_helper'
require './lib/dated'
require 'date'

class DatedTest < Minitest::Test

  def test_it_exists
    dated = Dated.new

    assert_instance_of Dated, dated
  end

  def test_it_can_return_current_date
    dated = Dated.new

    DateTime.stubs(:now).returns(DateTime.new(2020, 2, 29))

    assert_equal "29/02/20", dated.current_date
  end

  def test_it_can_return_transformed_date
    dated = Dated.new

    DateTime.stubs(:now).returns(DateTime.new(2020, 2, 29))


  end
end