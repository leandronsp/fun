require 'test/unit'

class Day4Test < Test::Unit::TestCase
  def build_range(range)
    range
      .split('-')
      .values_at(0, 1)
      .then { |(from, to)| (from.to_i..to.to_i) }
      .then(&:to_a)
  end

  def fully_contains?(left, right)
    intersection = left & right
    intersection == left || intersection == right
  end

  def overlapping?(left, right) = (left & right).size > 0

  def test_build_range
    assert_equal [2, 3, 4], build_range('2-4')
  end

  def test_fully_contains
    assert fully_contains?([3, 4], [1, 2, 3, 4])
    assert fully_contains?([1, 2, 3, 4], [3, 4])

    refute fully_contains?([3, 4], [4, 5, 6])
    refute fully_contains?([4, 5, 6], [3, 4])
  end

  def all_ranges(input)
    input
      .split("\n")
      .map { |row| row.split(",") }
      .map { |(left, right)| [build_range(left), build_range(right)] }
  end

  def pairs_containing_each_other(input)
    all_ranges(input)
      .select { |(left, right)| fully_contains?(left, right) }
      .size
  end

  def pairs_overlapping(input)
    all_ranges(input)
      .select { |(left, right)| overlapping?(left, right) }
      .size
  end

  def test_day_4
    input = File.read('2022/day-4/input-test')

    assert_equal 2, pairs_containing_each_other(input)
    assert_equal 4, pairs_overlapping(input)
  end
end
