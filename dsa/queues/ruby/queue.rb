@queue = []

@queue.push(1)
@queue.push(2)
@queue.push(3)

puts @queue.shift # 1
puts @queue.shift # 2
puts @queue.shift # 3
puts @queue.shift # nil
