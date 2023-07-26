class MedianQuickselect
  def self.median(list)
    size = list.length
    return nil if size == 0

    middle_position = size / 2

    if size % 2 == 1
      quickselect(list, middle_position)
    else
      lefty = quickselect(list, middle_position - 1)
      righty = quickselect(list, middle_position)

      (lefty + righty) / 2
    end

  end

  def self.quickselect(list, kth)
    return list[0] if list.length == 1

    pivot = list[0]
    tail = list[1..-1]
    smaller, larger = partition(pivot, tail)

    return pivot if kth == smaller.length

    if kth < smaller.length
      quickselect(smaller, kth)
    else
      quickselect(larger, kth - smaller.length - 1)
    end
  end

  def self.partition(pivot, list)
    smaller = []
    larger = []

    list.each do |item|
      if item <= pivot
        smaller << item
      else
        larger << item
      end
    end

    [smaller, larger]
  end
end

require 'test/unit'

class MedianQuickselectTest < Test::Unit::TestCase
  def test_quickselect
    list = [9, 8, 7, 6, 5, 0, 1, 2, 3, 4]
    assert_equal 0, MedianQuickselect.quickselect(list.dup, 0)
    assert_equal 4, MedianQuickselect.quickselect(list.dup, 4)

    list = [10, 4, 5, 6, 3, 1, 8]
    assert_equal 6, MedianQuickselect.quickselect(list.dup, 4)
    assert_equal 8, MedianQuickselect.quickselect(list.dup, 5)
  end

  def test_median
    list = [2, 5, 1, 6, 1]
    assert_equal 2, MedianQuickselect.median(list.dup)

    list = [2, 5, 1, 6, 4, 1]
    assert_equal 3, MedianQuickselect.median(list.dup)

    list = [1, 2, 3]
    assert_equal 2, MedianQuickselect.median(list.dup)

    list = [1,10,2,9]
    assert_equal 5, MedianQuickselect.median(list.dup)
  end
end
