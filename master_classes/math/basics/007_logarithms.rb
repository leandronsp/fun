require 'test/unit'

class LogarithmTest < Test::Unit::TestCase
  def logarithm(number, base)
    Math.log(number, base)
  end

  def test_logarithm_base_10
    result = logarithm(1000, 10)
    assert_in_delta(3, result, 0.001)
  end

  def test_logarithm_base_e
    result = logarithm(100, Math::E)
    assert_in_delta(4.605, result, 0.001)
  end

  def test_logarithm_base_2
    result = logarithm(8, 2)
    assert_equal(3, result)
  end
end
