require 'test/unit'
require 'byebug'

class SquareRootTest < Test::Unit::TestCase
  def sqrt(number)
    raise ArgumentError, 'Cannot compute square root of negative number' if number < 0
    return 0 if number == 0

    guess = number / 2.0
    prev_guess = 0

    # Babylonian method
    while guess != prev_guess
      prev_guess = guess
      guess = (guess + number / guess) / 2.0
    end

    guess
  end

  def test_sqrt_of_positive_number
    assert_equal(5, sqrt(25))
    assert_equal(57.087651904768336, sqrt(3259))
  end

  def test_sqrt_of_zero
    assert_equal(0, sqrt(0))
  end

  def test_sqrt_of_negative_number
    assert_raise(ArgumentError) { sqrt(-9) }
  end
end
