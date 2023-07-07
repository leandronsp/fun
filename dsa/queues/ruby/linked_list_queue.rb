class LinkedListQueue
  def initialize
    @head = nil
    @tail = nil
  end

  # O(1)
  def enqueue(element)
    node = [element, nil]

    if @head.nil?
      @head = node
      @tail = node
    else
      @tail[1] = node
      @tail = node
    end
  end

  # O(1)
  def dequeue
    return if @head.nil?

    @head[0].tap do
      @head = @head[1]
      @tail = nil if @head.nil?
    end
  end
end

@queue = LinkedListQueue.new

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
