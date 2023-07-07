require 'test/unit'
require 'byebug'

class Day5Test < Test::Unit::TestCase
  def cratemover_9000(input)
    stacks, instructions = parse(input)

    instructions.each do |instruction|
      stack_from = stacks[instruction[:from]]
      stack_to = stacks[instruction[:to]]

      instruction[:move].times do
        crate = stack_from.shift
        stack_to.prepend(crate)
      end
    end

    stacks
      .values
      .map { |value| value[0] }
      .join
  end

  def cratemover_9001(input)
    stacks, instructions = parse(input)

    instructions.each do |instruction|
      stack_from = stacks[instruction[:from]]
      stack_to = stacks[instruction[:to]]

      to_prepend = instruction[:move].times.map do
        stack_from.shift
      end

      stacks[instruction[:to]] = to_prepend + stack_to
    end

    stacks
      .values
      .map { |value| value[0] }
      .join
  end

  def parse(input)
    stacks = {}
    instructions = []

    input.split("\n").each do |line|
      parse_crates(line).each_with_index do |crate, idx|
        key = idx + 1

        stacks[key] ||= []
        stacks[key] << crate if crate
      end

      if instruction = parse_instruction(line)
        instructions << instruction
      end
    end

    [stacks, instructions]
  end

  def parse_crates(line)
    return [] unless line.match(/\[\w\]/)

    line
      .chars
      .each_slice(4)
      .to_a
      .map { |chunk| chunk[1] == " " ? nil : chunk[1] }
  end

  def parse_instruction(line)
    if matched = line.match(/move (\d+) from (\d+) to (\d+)/)
      captures = matched.captures

      { move: captures[0].to_i, from: captures[1].to_i, to: captures[2].to_i }
    end
  end

  def test_input
    input = File.read('2022/day-5/input-test')
    assert_equal 'CMZ', cratemover_9000(input)

    input = File.read('2022/day-5/input-test')
    assert_equal 'MCD', cratemover_9001(input)
  end

  def test_parse_crates
    assert_equal %w[P], parse_crates("[P]")
    assert_equal %w[P M S], parse_crates("[P] [M] [S]")
    assert_equal %w[P M], parse_crates("[P] [M]")

    assert_equal ['M', nil, 'S'], parse_crates("[M]     [S]")
    assert_equal [nil, 'S'], parse_crates("    [S]")
    assert_equal [nil, nil, 'S'], parse_crates("        [S]")
    assert_equal [nil, 'M', 'S'], parse_crates("    [M] [S]")

    assert_equal [], parse_crates("move 1 from 2 to 1")
  end

  def test_parse_instruction
    expected = { move: 3, from: 1, to: 2 }

    assert_equal expected, parse_instruction('move 3 from 1 to 2')
  end

  def test_parse
    input = File.read('2022/day-5/input-test')

    stacks, instructions = parse(input)

    assert_equal stacks[1], %w[N Z]
    assert_equal stacks[2], %w[D C M]
    assert_equal stacks[3], %w[P]

    assert_equal instructions[0], { move: 1, from: 2, to: 1 }
  end
end
