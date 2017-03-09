class Hamming
  def self.compute(strand_a, strand_b)
    chars_a, chars_b = strand_a.chars, strand_b.chars
    raise ArgumentError if chars_a.length != chars_b.length

    do_compute(chars_a, chars_b, 0)
  end

  private

  def self.do_compute(chars_a, chars_b, acc)
    return acc if chars_a.length == 0

    char_a, char_b = chars_a.pop, chars_b.pop
    diff = difference(char_a, char_b)

    do_compute(chars_a, chars_b, acc + diff)
  end

  def self.difference(char_a, char_b)
    char_a == char_b ? 0 : 1
  end
end
