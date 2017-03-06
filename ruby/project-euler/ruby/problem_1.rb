# multiples of 3 or 5 below 1000
# http://projecteuler.net/problem=1
#

(1...1000).inject(0) do |buffer, n|
  buffer ||= 0
  if n % 3 == 0 || n % 5 == 0
    buffer += n
  end
  buffer
end
