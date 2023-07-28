require 'test/unit'

class Queue
  def initialize
    @store = []
  end

  def push(value)
    @store.push(value)
  end

  def pop
    @store.shift
  end
end

class QueueTest < Test::Unit::TestCase
  def test_queue
    queue = Queue.new

    queue.push(1)
    queue.push(2)
    queue.push(3)

    assert_equal(1, queue.pop)
    assert_equal(2, queue.pop)
    assert_equal(3, queue.pop)

    assert_nil(queue.pop)
  end
end
