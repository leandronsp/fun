require 'test/unit'

class PrimeNumberTest < Test::Unit::TestCase
  def prime?(number)
    return false if number <= 1

    (2..Math.sqrt(number)).each do |divisor|
      return false if number % divisor == 0
    end

    true
  end

  def test_prime_number
    # 17 is a prime number because it is only divisible by 1 and 17
    assert_equal(true, prime?(17))

    # 2 is a prime number because it is only divisible by 1 and 2
    assert_equal(true, prime?(2))
  end

  def test_non_prime_number
    assert_equal(false, prime?(0))
    assert_equal(false, prime?(-1))

    # 21 is not a prime number because it is divisible by 3 and 7
    assert_equal(false, prime?(21))
  end
end
