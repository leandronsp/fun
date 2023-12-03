# An implementation of Quicksort with some test scenarios using Test::Unit

require 'test/unit'

class Array
  # A quicksort implementation for arrays
  def quicksort
    return [] if empty?

    pivot = delete_at(rand(size))
    left, right = partition(&pivot.method(:>))

    return *left.quicksort, pivot, *right.quicksort
  end

  # A merge sort implementation for arrays
  def mergesort
    return self if length <= 1

    middle = length / 2
    left = self[0, middle].mergesort
    right = self[middle, length - middle].mergesort

    merge(left, right)
  end

  def merge(left, right)
    sorted = []
    until left.empty? || right.empty?
      sorted << (left.first <= right.first ? left.shift : right.shift)
    end
    sorted + left + right
  end
end

# Testing the quicksort implementation
class TestQuicksort < Test::Unit::TestCase
  def test_quicksort
    assert_equal [], [].quicksort
    assert_equal [1], [1].quicksort
    assert_equal [1, 2], [1, 2].quicksort
    assert_equal [1, 2], [2, 1].quicksort
    assert_equal [1, 2, 3], [1, 2, 3].quicksort
    assert_equal [1, 2, 3], [1, 3, 2].quicksort
    assert_equal [1, 2, 3], [2, 1, 3].quicksort
    assert_equal [1, 2, 3], [2, 3, 1].quicksort
    assert_equal [1, 2, 3], [3, 1, 2].quicksort
    assert_equal [1, 2, 3], [3, 2, 1].quicksort
    assert_equal [1, 2, 3, 4], [1, 2, 3, 4].quicksort
    assert_equal [1, 2, 3, 4], [1, 2, 4, 3].quicksort
    assert_equal [1, 2, 3, 4], [1, 3, 2, 4].quicksort
    assert_equal [1, 2, 3, 4], [1, 3, 4, 2].quicksort
    assert_equal [1, 2, 3, 4], [1, 4, 2, 3].quicksort
    assert_equal [1, 2, 3, 4], [1, 4, 3, 2].quicksort
    assert_equal [1, 2, 3, 4], [2, 1, 3, 4].quicksort
    assert_equal [1, 2, 3, 4], [2, 1, 4, 3].quicksort
    assert_equal [1, 2, 3, 4], [2, 3, 1, 4].quicksort
  end
end

# Testing the mergesort implementation
class TestMergesort < Test::Unit::TestCase
  def test_mergesort
    assert_equal [], [].mergesort
    assert_equal [1], [1].mergesort
    assert_equal [1, 2], [1, 2].mergesort
    assert_equal [1, 2], [2, 1].mergesort
    assert_equal [1, 2, 3], [1, 2, 3].mergesort
    assert_equal [1, 2, 3], [1, 3, 2].mergesort
    assert_equal [1, 2, 3], [2, 1, 3].mergesort
    assert_equal [1, 2, 3], [2, 3, 1].mergesort
    assert_equal [1, 2, 3], [3, 1, 2].mergesort
    assert_equal [1, 2, 3], [3, 2, 1].mergesort
    assert_equal [1, 2, 3, 4], [1, 2, 3, 4].mergesort
    assert_equal [1, 2, 3, 4], [1, 2, 4, 3].mergesort
    assert_equal [1, 2, 3, 4], [1, 3, 2, 4].mergesort
    assert_equal [1, 2, 3, 4], [1, 3, 4, 2].mergesort
    assert_equal [1, 2, 3, 4], [1, 4, 2, 3].mergesort
    assert_equal [1, 2, 3, 4], [1, 4, 3, 2].mergesort
    assert_equal [1, 2, 3, 4], [2, 1, 3, 4].mergesort
    assert_equal [1, 2, 3, 4], [2, 1, 4, 3].mergesort
    assert_equal [1, 2, 3, 4], [2, 3, 1, 4].mergesort
  end
end
