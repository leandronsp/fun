require 'test/unit'
require 'byebug'

require_relative 'lib/smaller_numbers'

class SmallerNumbersTtest < Test::Unit::TestCase
  include SmallerNumbers

  def test_smaller_numbers
    assert_equal([4, 0, 1, 1, 3], smaller_numbers([8, 1, 2, 2, 3]))
    assert_equal([2, 1, 0, 3], smaller_numbers([6, 5, 4, 8]))
    assert_equal([0, 0, 0, 0], smaller_numbers([7, 7, 7, 7]))
  end
end
