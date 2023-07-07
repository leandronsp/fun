class LIFOQueue
  def initialize
    @stack = []
    @amortized = []
  end

  def enqueue(element)
    @stack.push(element)
  end

  def dequeue
    @amortized.push(@stack.pop) until @stack.empty?
    @amortized.pop
  end
end

@queue = LIFOQueue.new

@queue.enqueue(1)
@queue.enqueue(2)
@queue.enqueue(3)

puts @queue.dequeue # 1
puts @queue.dequeue # 2
puts @queue.dequeue # 3
puts @queue.dequeue # nil

@queue.enqueue(4)

puts @queue.dequeue # 4

@queue.enqueue(5)
@queue.enqueue(6)

puts @queue.dequeue # 5

@queue.enqueue(7)

puts @queue.dequeue # 6
puts @queue.dequeue # 7
puts @queue.dequeue # nil
