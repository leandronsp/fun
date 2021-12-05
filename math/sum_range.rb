require 'benchmark'

def sum_range_using_for_loop(min, max)
  range = (min..max)
  sum   = 0

  for n in range
    sum = sum + n
  end

  sum
end

def sum_range_using_math(min, max)
  sum_max = max * (1 + max) / 2
  sum_min = min * (1 + min) / 2

  sum_max - sum_min + min
end

min = 1
max = 123456789

Benchmark.bm do |x|
  x.report('for loop') {  sum_range_using_for_loop(min, max) }
  x.report('math')     {  sum_range_using_math(min, max) }
end

#### Results #####

#------> for loop: 6.87s
#------> math:     0.000008s
