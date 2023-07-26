require 'test/unit'

class PowerTest < Test::Unit::TestCase
  def power(base, exponent)
    base ** exponent
  end

  def test_power_operator
    assert_equal(8, power(2, 3))
  end

  def test_power_math_method
    assert_equal(81, power(3, 4))
  end

  def test_power_fractional_exponent
    result = power(4, 0.5)
    assert_in_delta(2, result, 0.001)
  end
end

