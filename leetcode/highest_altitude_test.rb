require 'test/unit'
require 'byebug'

require_relative 'lib/highest_altitude'

class HighestAltitudeTest < Test::Unit::TestCase
  include HighestAltitude

  def test_highest_altitude
    assert_equal(1, highest_altitude([-5, 1, 5, 0, -7]))
    assert_equal(0, highest_altitude([-4, -3, -2, -1, 4, 3, 2]))
  end
end
