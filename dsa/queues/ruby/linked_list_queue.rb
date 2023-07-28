require 'test/unit'
require 'byebug'

class Node
  attr_accessor :value, :next, :prev

  def initialize(value)
    @value = value
    @next = nil
  end
end

class LinkedListQueue
  def initialize
    @head = nil
    @tail = nil
  end

  # O(1)
  def enqueue(value)
    node = Node.new(value)

    if @head.nil?
      @head = node
      @tail = node

      return
    end

    @tail.next = node
    @tail = node
  end

  # O(1)
  def dequeue
    return unless @head

    @head.tap do
      @head = @head.next
      @tail = nil if @head.nil?
    end.value
  end
end

class LinkedListQueueTest < Test::Unit::TestCase
  def test_queue
    queue = LinkedListQueue.new

    queue.enqueue(1)
    queue.enqueue(2)
    queue.enqueue(3)

    assert_equal 1, queue.dequeue
    assert_equal 2, queue.dequeue
    assert_equal 3, queue.dequeue

    assert_nil queue.dequeue

    queue.enqueue(4)
    queue.enqueue(5)

    assert_equal 4, queue.dequeue
    assert_equal 5, queue.dequeue

    assert_nil queue.dequeue
  end
end
