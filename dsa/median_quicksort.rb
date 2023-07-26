class MedianQuicksort
  def self.median(list)
    sorted = sort(list)
    size = sorted.length
    middle = size / 2

    return nil if size == 0
    return sorted[middle] unless size % 2 == 0

    (sorted[middle - 1] + sorted[middle]) / 2
  end

  def self.sort(list)
    return list if list.length < 2

    pivot = list[0]
    tail = list[1..-1]

    smaller, larger = partition(pivot, tail, [], [])

    sort(smaller) + [pivot] + sort(larger)
  end

  def self.partition(pivot, list, smaller, larger)
    return [smaller, larger] if list.length == 0

    head = list[0]
    tail = list[1..-1]

    if head <= pivot
      partition(pivot, tail, [head] + smaller, larger)
    else
      partition(pivot, tail, smaller, [head] + larger)
    end
  end
end

require 'test/unit'

class MedianQuicksortTest < Test::Unit::TestCase
  def test_median
    list = [2, 5, 1, 6, 1]
    assert_equal 2, MedianQuicksort.median(list.dup)

    list = [2, 5, 1, 6, 4, 1]
    assert_equal 3, MedianQuicksort.median(list.dup)
  end

  def test_partition
    list = [4, 2, 1, 6, 3, 5, 7]
    assert_equal [[3, 1, 2, 4], [7, 5, 6]], MedianQuicksort.partition(4, list.dup, [], [])
    assert_equal [[1], [7, 5, 3, 6, 2, 4]], MedianQuicksort.partition(1, list.dup, [], [])
    assert_equal [[5, 3, 1, 2, 4], [7, 6]], MedianQuicksort.partition(5, list.dup, [], [])

    list = [2, 5, 1, 6, 1]
    assert_equal [[1, 1, 2], [6, 5]], MedianQuicksort.partition(2, list.dup, [], [])
  end

  def test_sort
    list = [2, 5, 1, 6, 1]
    assert_equal [1, 1, 2, 5, 6], MedianQuicksort.sort(list.dup)

    list = [8, 2, 4, 1, 3]
    assert_equal [1, 2, 3, 4, 8], MedianQuicksort.sort(list.dup)
  end
end
