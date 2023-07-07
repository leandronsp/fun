require 'test/unit'
require 'byebug'

require_relative 'lib/sum_of_two_integers'

class SumOfTwoIntegersTest < Test::Unit::TestCase
  include SumOfTwoIntegers

  def test_get_sum
    assert_equal(3, get_sum(1, 2))
    assert_equal(5, get_sum(2, 3))
    assert_equal(1, get_sum(-2, 3))
    assert_equal(0, get_sum(-1, 1))
    assert_equal(0, get_sum(0, 0))
    assert_equal(4, get_sum(10, -6))
    assert_equal(-20, get_sum(-12, -8))
  end
end
