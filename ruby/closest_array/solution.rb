require 'test/unit'

def calculate(array, k, v)
  proximities = []

  array.each do |elem|
    factor = (elem.to_f / v.to_f)
    proximity = (1 - factor).abs
    proximities << [elem, proximity]
  end

  sorted = proximities.sort { |pair_a, pair_b| pair_a[1] <=> pair_b[1] }
  values = sorted.map { |pair| pair[0] }

  result = []

  k.times do |idx|
    result << values[idx]
  end

  result.sort
end

class ClosestArrayTest < Test::Unit::TestCase
  def test_closest_array
    assert_equal calculate([0, 1, 2, 4, 10, 11, 12], 2, 3), [2, 4]
    assert_equal calculate([0, 1, 2, 4, 10, 11, 12], 3, 6), [2, 4, 10]
    assert_equal calculate([0, 1, 2, 4, 10, 11, 12], 3, 9), [10, 11, 12]
    assert_equal calculate([12, 16, 22, 30, 39, 42, 45, 48, 50, 53, 55, 56], 2, 35), [30, 39]
  end
end
