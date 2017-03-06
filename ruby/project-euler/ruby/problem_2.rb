# even fibonacci numbers under 4_000_000
#

LIMIT = 4_000_000

def build_sequence(buffer, elem, previous = 0)
  return elem if elem >= LIMIT
  buffer << elem + previous

  build_sequence buffer, (elem + previous), elem
end

fib_sequence = [1].inject([]) do |buffer, elem|
  build_sequence(buffer, elem)
  buffer
end

even_valued_sum = fib_sequence.inject(0) do |sum, elem|
  sum ||= 0
  sum += elem if elem % 2 == 0
  sum
end

puts even_valued_sum
