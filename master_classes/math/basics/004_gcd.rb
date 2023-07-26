require 'test/unit'

class GCDTest < Test::Unit::TestCase
  def gcd(a, b)
    while b != 0
      remainder = a % b
      a = b
      b = remainder
    end
    a
  end

  def test_gcd_positive_numbers
    assert_equal(6, gcd(48, 18))
  end

  def test_gcd_negative_numbers
    assert_equal(6, gcd(-48, 18))
  end

  def test_gcd_zero
    assert_equal(48, gcd(48, 0))
  end
end
