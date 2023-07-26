require 'test/unit'

def is_divisible?(number, divisor)
  number % divisor == 0
end

def find_factors(number)
  (1..number)
    .select(&method(:is_divisible?).curry[number])
end

class TestNumberTheory < Test::Unit::TestCase
  def test_is_divisible
    assert_equal(true, is_divisible?(12, 3))
    assert_equal(false, is_divisible?(15, 4))
  end

  def test_find_factors
    assert_equal([1, 2, 3, 4, 6, 12], find_factors(12))
    assert_equal([1, 3, 5, 15], find_factors(15))
  end
end
