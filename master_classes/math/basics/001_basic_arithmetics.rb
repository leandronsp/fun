require 'test/unit'

class IntegerOperationsTest < Test::Unit::TestCase
  def test_addition
    result = 2 + 3
    assert_equal(5, result)
  end

  def test_subtraction
    result = 5 - 2
    assert_equal(3, result)
  end

  def test_multiplication
    result = 4 * 3
    assert_equal(12, result)
  end

  def test_division
    result = 10 / 2
    assert_equal(5, result)
  end
end
