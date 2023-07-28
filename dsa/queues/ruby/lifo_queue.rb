require 'test/unit'

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

class LIFOQueueTest < Test::Unit::TestCase
  def test_lifo_queue
    queue = LIFOQueue.new

    queue.enqueue(1)
    queue.enqueue(2)
    queue.enqueue(3)

    assert_equal(1, queue.dequeue)
    assert_equal(2, queue.dequeue)
    assert_equal(3, queue.dequeue)

    assert_nil(queue.dequeue)
  end
end
