require 'byebug'
require 'test/unit'

class CircularQueue
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

class CircularQueueTest < Test::Unit::TestCase
  def test_circular_queue
    queue = CircularQueue.new(3)

    queue.enqueue(1)
    queue.enqueue(2)
    queue.enqueue(3)

    assert_equal(1, queue.dequeue)
    assert_equal(2, queue.dequeue)
    assert_equal(3, queue.dequeue)

    assert_nil(queue.dequeue)

    queue.enqueue(4)
    queue.enqueue(5)
    queue.enqueue(6)

    assert_equal(4, queue.dequeue)
    assert_equal(5, queue.dequeue)
    assert_equal(6, queue.dequeue)

    assert_nil(queue.dequeue)
  end
end
