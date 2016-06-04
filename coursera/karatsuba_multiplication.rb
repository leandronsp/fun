require 'pry'

class Karatsuba
  def self.multiply(x, y)
    return x * y if x < 10 || y < 10

    high = [x,y].max
    low  = [x,y].min

    split_factor = high.to_s.length / 2

    a, b = high.to_s.chars.each_slice(split_factor).map(&:join).map(&:to_i)
    c, d = low.to_s.chars.each_slice(split_factor).map(&:join).map(&:to_i)

    step_1 = multiply a, c
    step_2 = multiply b, d
    step_3 = multiply a + b, c + d

    step_4 = step_3 - step_2 - step_1

    result_1 = (10 ** (2 * split_factor)) * step_1
    result_2 = (10 ** split_factor) * step_4

    step_2 + result_1 + result_2
  end
end

n1 = 1234
n2 = 5678
result = Karatsuba.multiply(n1, n2)

puts result
puts n1 * n2

n1 = 12345
n2 = 12345
result = Karatsuba.multiply(n1, n2)

puts result
puts n1 * n2
