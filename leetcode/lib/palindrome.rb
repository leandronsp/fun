module Palindrome
  # Leetcode Problem #9 - Palindrome Number
  # Determine whether an integer is a palindrome. Do this without extra space.
  # Follow up: Could you solve it without converting the integer to a string?

  def palindrome?(number)
    reversed_number = 0
    original_number = number

    while number > 0
      right_most = number % 10
      number /= 10

      reversed_number = 10 * reversed_number + right_most
    end

    original_number == reversed_number
  end
end
