class LargestPrimeFactor

  #############################################
  # The prime factors of 13195 are 5, 7, 13 and 29.
  # What is the largest prime factor of the number 600851475143 ?
  #############################################

  def self.largest_prime_factor(number)
    number = number / 2 while number % 2 == 0
    return 2 if number == 1

    prime = 3
    largest = 0

    while prime < Math.sqrt(number)
      while number % prime == 0
        number = number / prime
        largest = prime
      end

      prime += 2
    end

    number > 2 ? number : largest
  end

end
