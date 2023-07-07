require 'test/unit'
require 'byebug'

require_relative 'lib/concat_array'

class ConcatArrayTest < Test::Unit::TestCase
  include ConcatArray

  def test_concat
    assert_equal([1, 2, 1, 2], concat([1, 2]))
    assert_equal([1, 2, 3, 1, 2, 3], concat([1, 2, 3]))
    assert_equal([1, 2, 1, 1, 2, 1], concat([1, 2, 1]))
  end
end
