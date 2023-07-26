require 'test/unit'

class LCMTest < Test::Unit::TestCase
  def lcm(a, b)
    (a.abs / gcd(a, b)) * b.abs
  end

  def gcd(a, b)
    while b != 0
      remainder = a % b
      a = b
      b = remainder
    end
    a
  end

  def test_lcm_positive_numbers
    result = lcm(12, 18)
    assert_equal(36, result)
  end

  def test_lcm_negative_numbers
    result = lcm(-12, 18)
    assert_equal(36, result)
  end

  def test_lcm_zero
    result = lcm(0, 5)
    assert_equal(0, result)
  end
end
