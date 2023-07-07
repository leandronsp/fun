module IntegerToRoman
  # Leetcode Problem #12 - Integer to Roman
  # Given an integer, convert it to a roman numeral.
  # Input is guaranteed to be within the range from 1 to 3999.

  TABLE = {
    'I' => 1, 'IV' => 4, 'V' => 5, 'IX' => 9, 'X' => 10,
    'XL' => 40, 'L' => 50, 'XC' => 90, 'C' => 100,
    'CD' => 400, 'D' => 500, 'CM' => 900, 'M' => 1000
  }.invert

  def integer_to_roman(number)
    TABLE[number] || convert(number)
  end

  def convert(number) 
      
  end

  def convert(number, acc = '')
    return acc if [0, 4, 9].include?(number)

    basenum = basenum_for(number)
    basetoken = TABLE[basenum] * (number / basenum)

    number = number % basenum
    modifier = [4, 9].include?(number) ? TABLE[number] : ''

    convert(number, acc + basetoken + modifier)
  end

  def basenum_for(number)
    TABLE.keys.reverse.find { |basenum| number % basenum < number }
  end
end
