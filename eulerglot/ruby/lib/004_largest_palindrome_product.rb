class LargestPalindromeProduct

  def self.calc(digit, limit = 9999999999)
    determine_max = lambda { |d| ("9" * d).to_i }
    determine_min = lambda { |d| ("1" + ("0" * (d - 1))).to_i }
    palindrome    = lambda { |n| n.to_s.reverse == n.to_s }

    max     = determine_max.call(digit)
    min     = determine_min.call(digit)
    largest = 0

    (min..max).each do |left|
      (left..max).each do |right|
        product = left * right
        largest = product if product < limit && palindrome.call(product) && product > largest
      end
    end

    largest
  end

end
