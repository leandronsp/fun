require 'test/unit'
require 'byebug'

class Deque
  attr_reader :items

  def initialize
    @items = []
  end

  def rpush(item)
    @items.push(item)
  end

  def lpush(item)
    @items.unshift(item)
  end

  def rpop
    @items.pop
  end

  def lpop
    @items.shift
  end
end

class DequeTest < Test::Unit::TestCase
  def test_queue
    queue = Deque.new

    queue.rpush(1)
    queue.rpush(2)
    queue.rpush(3)

    assert_equal(1, queue.lpop)
    assert_equal(2, queue.lpop)
    assert_equal(3, queue.lpop)

    assert_nil(queue.lpop)
  end

  def test_stack
    stack = Deque.new

    stack.lpush(1)
    stack.lpush(2)
    stack.lpush(3)

    assert_equal(3, stack.lpop)
    assert_equal(2, stack.lpop)
    assert_equal(1, stack.lpop)

    assert_nil(stack.lpop)
  end

  def test_mixed
    deque = Deque.new

    deque.rpush(1)
    deque.rpush(2)
    deque.lpush(3)
    deque.rpush(4)
    deque.lpush(5)

    assert_equal(5, deque.lpop)
    assert_equal(3, deque.lpop)
    assert_equal(1, deque.lpop)
    assert_equal(2, deque.lpop)
    assert_equal(4, deque.lpop)

    deque.rpush(1)
    deque.rpush(2)
    deque.lpush(3)
    deque.lpush(4)

    assert_equal(4, deque.lpop)
    assert_equal(2, deque.rpop)
    assert_equal(1, deque.rpop)
    assert_equal(3, deque.lpop)

    assert_nil(deque.lpop)
    assert_nil(deque.rpop)
  end
end
