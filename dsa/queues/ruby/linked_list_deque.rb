require 'test/unit'
require 'byebug'

class Node
  attr_accessor :value, :next, :prev

  def initialize(value)
    @value = value
    @next = nil
    @prev = nil
  end
end

class LinkedListDeque
  def initialize
    @head = nil
    @tail = nil
  end

  def rpush(value)
    node = Node.new(value)

    if @tail.nil?
      @tail = node
      @head = node
      return
    end

    node.prev = @tail
    @tail.next = node
    @tail = node
  end

  def lpush(value)
    node = Node.new(value)

    if @head.nil?
      @head = node
      @tail = node
      return
    end

    node.next = @head
    @head.prev = node
    @head = node
  end

  def rpop
    return unless @tail

    @tail.value.tap do
      @tail = @tail.prev
      @tail.next = nil if @tail
      @head = nil unless @tail
    end
  end

  def lpop
    return unless @head

    @head.value.tap do
      @head = @head.next
      @head.prev = nil if @head
      @tail = nil unless @head
    end
  end

  # O(n)
  def to_a
    array = []

    pointer = @head

    while pointer
      array << pointer.value

      pointer = pointer.next
    end

    array
  end
end

class LinkedListDequeTest < Test::Unit::TestCase
  def test_queue
    queue = LinkedListDeque.new

    queue.rpush(1)
    queue.rpush(2)
    queue.rpush(3)

    assert_equal(1, queue.lpop)
    assert_equal(2, queue.lpop)
    assert_equal(3, queue.lpop)

    assert_nil(queue.lpop)
  end

  def test_stack
    stack = LinkedListDeque.new

    stack.lpush(1)
    stack.lpush(2)
    stack.lpush(3)

    assert_equal(3, stack.lpop)
    assert_equal(2, stack.lpop)
    assert_equal(1, stack.lpop)

    assert_nil(stack.lpop)
  end

  def test_mixed
    deque = LinkedListDeque.new

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
