require 'test/unit'

class DayOneTest < Test::Unit::TestCase
  def calories_ranking(lines)
    acc = 0
    calories = []
    size = lines.size

    lines.each_with_index do |line, idx|
      next (calories << acc && acc = 0) if line.empty?

      acc += line.to_i
      calories << acc if idx == (size - 1)
    end

    sorted = calories.sort.reverse
    first, second, third = sorted.values_at(0, 1, 2)

    [first, (first + second + third)]
  end

  def test_day_1
    lines = ["1", "2", "3", "", "3", "", "9", "10", "", "1", "6"]

    assert_equal [19, 32], calories_ranking(lines)
  end
end
