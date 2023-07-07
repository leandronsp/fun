require 'test/unit'
require 'byebug'

class Day7Test < Test::Unit::TestCase
  def build_tree(input)
    lines = input.split("\n")

    result = feed(lines)
    byebug
  end

  def feed(lines)
    data = {}

    lines.each do |line|
      dirname = parse_dir(line)

      if dirname
        data[dirname] ||= []
      end

    end

    data
  end

  def parse_dir(line)
    pattern = /\$ cd (.*)/
    return unless line.match(pattern)

    line.scan(pattern).flatten.first
  end

  def test_day_7
    input = File.read('2022/day-7/input-test')

    build_tree(input)
  end
end
