def map(numbers)
  return unless block_given?

  result = []

  for number in numbers
    result << yield(number) 
  end

  result
end

puts map([1, 2, 3]) { |number| number * 2 }
puts map([1, 2, 4]) 
