require 'test/unit'

class Day3Test < Test::Unit::TestCase
  def alphabet_idx
    @alphabet_idx ||=
      begin
        (('a'..'z').to_a + ('A'..'Z').to_a)
          .each_with_object({})
          .with_index do |(letter, acc), index|
            acc[letter] = index + 1
          end
      end
  end

  def code(letter) = alphabet_idx[letter]
  def half(str) = str.chars.each_slice(str.size / 2).to_a

  def repeated(parts, acc = parts[0])
    return acc if parts.size < 2

    repeated(parts[1..-1], acc & parts[1])
  end

  def sum_each_half_of(input)
    input
      .split("\n")
      .map(&method(:half))
      .flat_map(&method(:repeated))
      .sum(&method(:code))
  end

  def sum_each_three_of(input)
    input
      .split("\n")
      .map(&:chars)
      .each_slice(3)
      .flat_map(&method(:repeated))
      .sum(&method(:code))
  end

  def test_day_3
    input = "vJrwpWtwJgWrhcsFMMfFFhFp\njqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL\nPmmdzqPrVvPwwTWBwg\nwMqvLMZHhHMvwLHjbvcjnnSBnvTQFn\nttgJtRGJQctTZtZT\nCrZsJsPPZsGzwwsLwLmpwMDw"

    assert_equal 157, sum_each_half_of(input)
    assert_equal 70, sum_each_three_of(input)
  end
end
