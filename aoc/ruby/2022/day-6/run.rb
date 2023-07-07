require 'test/unit'
require 'byebug'
require 'set'

class Day6Test < Test::Unit::TestCase
  def nth_packet_marker(input) = nth_marker(input, block_size: 4)
  def nth_message_marker(input) = nth_marker(input, block_size: 14)

  def nth_marker(input, block_size:)
    chars = input.chars

    chars.each_with_index do |char, idx|
      slice = chars.values_at(idx..idx + (block_size - 1))

      return idx + block_size if slice.uniq.size == block_size
    end
  end

  def test_day_6
    assert_equal 7, nth_packet_marker('mjqjpqmgbljsphdztnvjfqwrcgsmlb')
    assert_equal 5, nth_packet_marker('bvwbjplbgvbhsrlpgdmjqwftvncz')
    assert_equal 6, nth_packet_marker('nppdvjthqldpwncqszvftbrmjlhg')
    assert_equal 10, nth_packet_marker('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg')

    assert_equal 19, nth_message_marker('mjqjpqmgbljsphdztnvjfqwrcgsmlb')
    assert_equal 23, nth_message_marker('bvwbjplbgvbhsrlpgdmjqwftvncz')
    assert_equal 23, nth_message_marker('nppdvjthqldpwncqszvftbrmjlhg')
    assert_equal 29, nth_message_marker('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg')
  end
end
