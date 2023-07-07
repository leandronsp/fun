require 'test/unit'
require 'byebug'

require_relative 'lib/shuffle_the_array'

class ShuffleTheArrayTest < Test::Unit::TestCase
  include ShuffleTheArray

  def test_shuffle
    assert_equal([2, 3, 5, 4, 1, 7], shuffle([2, 5, 1, 3, 4, 7], 3))
    assert_equal([1, 4, 2, 3, 3, 2, 4, 1], shuffle([1, 2, 3, 4, 4, 3, 2, 1], 4))
    assert_equal([1, 2, 1, 2], shuffle([1, 1, 2, 2], 2))
  end
end
