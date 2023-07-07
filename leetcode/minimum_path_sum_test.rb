require 'test/unit'
require 'byebug'

require_relative 'lib/minimum_path_sum'

class MinimumPathSumTest < Test::Unit::TestCase
  include MinimumPathSum

  def test_min_recursive
    assert_equal(3, min_recursive([[1, 2], [1, 1]]))
    assert_equal(12, min_recursive([[1, 2, 3], [4, 5, 6]]))
    assert_equal(7, min_recursive([[1, 3, 1], [1, 5, 1], [4, 2, 1]]))
    assert_equal(9, min_recursive([[1, 6, 1], [1, 5, 1], [5, 2, 1]]))
  end

  def test_min_dp
    #assert_equal(3, min_dp([[1, 2], [1, 1]]))
    assert_equal(12, min_dp([[1, 2, 3], [4, 5, 6]]))
    assert_equal(7, min_dp([[1, 3, 1], [1, 5, 1], [4, 2, 1]]))
    assert_equal(9, min_dp([[1, 6, 1], [1, 5, 1], [5, 2, 1]]))
  end
end
