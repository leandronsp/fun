require 'byebug'

class CBQueue
  attr_reader :buffer , :start, :end

  def initialize(capacity = 5)
    @buffer = Array.new(capacity)
    @start = 0
    @end = 0
  end

  def enqueue(element)
    resize if full?

    @buffer[@end] = element
    @end = (@end + 1) % @buffer.size
  end

  def dequeue
    return if empty?

    @buffer[@start].tap do
      @buffer[@start] = nil
      @start = (@start + 1) % @buffer.size
    end
  end

  def resize
    new_buffer = Array.new(@buffer.size * 2)
    idx = 0

    while !empty?
      new_buffer[idx] = dequeue
      idx += 1
    end

    @buffer = new_buffer
    @start = 0
    @end = idx
  end

  def full? = @buffer[@end]
  def empty? = !@buffer[@start]
end

@queue = CBQueue.new(1)

@queue.enqueue(1)
@queue.enqueue(2)
@queue.enqueue(3)

puts @queue.dequeue # 1
puts @queue.dequeue # 2
puts @queue.dequeue # 3
puts @queue.dequeue # nil
