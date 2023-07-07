module RomanToInteger
  # Leetcode Problem #13 - Roman to Integer
  # Given a roman numeral, convert it to an integer.
  # Input is guaranteed to be within the range from 1 to 3999.

  def roman_to_integer(roman)
    table = {
      'I' => 1,
      'V' => 5,
      'X' => 10,
      'L' => 50,
      'C' => 100,
      'D' => 500,
      'M' => 1000
    }

    tokens = roman.chars

    tokens.each_with_index.reduce(0) do |sum, (token, idx)|
      next_token = tokens[idx + 1]

      value = table[token]
      next_value = table[next_token]

      next_value && next_value > value ? sum -= value : sum += value
    end
  end
end
