require 'test/unit'
require 'byebug'

class CBDeque
  def initialize(capacity = 1)
    @buffer = Array.new(capacity)
    @left = 0
    @right = 0
  end

  def rpush(element)
    resize if full?

    @buffer[@right] = element
    @right = (@right + 1) % @buffer.size
  end

  def lpush(element)
    if full?
      resize
      @left = @buffer.size - 1
    else
      @left = (@left - 1) % @buffer.size
    end

    @buffer[@left] = element
  end

  def rpop
    return if empty?

    shift = (@right - 1) % @buffer.size
    idx = @buffer[@right] ? @right : shift

    @buffer[idx].tap do
      @buffer[idx] = nil
      @right = shift
    end
  end

  def lpop
    return if empty?

    shift = (@left + 1) % @buffer.size
    idx = @buffer[@left] ? @left : shift

    @buffer[idx].tap do
      @buffer[idx] = nil
      @left = shift
    end
  end

  def resize
    new_buffer = Array.new(@buffer.size * 2)
    idx = 0

    while !empty?
      new_buffer[idx] = lpop
      idx += 1
    end

    @buffer = new_buffer
    @left = 0
    @right = idx
  end

  def full? = @buffer[@right] && (@left == @right)
  def empty? = !@buffer[@left] && (@left == @right)
end

class DequeTest < Test::Unit::TestCase
  def test_queue
    queue = CBDeque.new

    queue.rpush(1)
    queue.rpush(2)
    queue.rpush(3)

    assert_equal(1, queue.lpop)
    assert_equal(2, queue.lpop)
    assert_equal(3, queue.lpop)

    assert_nil(queue.lpop)
  end

  def test_stack
    stack = CBDeque.new

    stack.lpush(1)
    stack.lpush(2)
    stack.lpush(3)

    assert_equal(3, stack.lpop)
    assert_equal(2, stack.lpop)
    assert_equal(1, stack.lpop)

    assert_nil(stack.lpop)
  end

  def test_mixed
    deque = CBDeque.new

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
