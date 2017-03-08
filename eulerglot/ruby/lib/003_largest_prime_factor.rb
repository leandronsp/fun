class LargestPrimeFactor

  #############################################
  # The prime factors of 13195 are 5, 7, 13 and 29.
  # What is the largest prime factor of the number 600851475143 ?
  #############################################

  def self.largest_prime_factor(number)
    prime_factorization(number).max
  end

  def self.prime_factorization(number)
    prime_factors(2, number, [])
  end

  def self.prime_factors(start, number, arr)
    if number == start
      arr << start
      return arr
    end

    if number % start == 0
      prime_factors(start, number / start, (arr << start))
    else
      prime_factors(start + 1, number, arr)
    end
  end

end
