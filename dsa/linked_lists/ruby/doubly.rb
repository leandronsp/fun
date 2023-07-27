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

class DoublyLinkedList
  attr_accessor :head, :tail

  # O(1)
  def add_left(value)
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

  # O(1)
  def add_right(value)
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

  # O(1)
  def remove_left
    return unless @head

    @head = @head.next
    @head.prev = nil if @head
  end

  # O(1)
  def remove_right
    return unless @tail

    @tail = @tail.prev
    @tail.next = nil if @tail
  end

  # O(n)
  def remove_at(idx)
    return remove_left if idx.zero?

    found = find_at(idx)
    return unless found

    prev = found.prev
    return unless prev

    found.next.prev = prev
    prev.next = found.next
  end

  # O(n)
  def add_at(idx, value)
    return add_left(value) if idx.zero?

    found = find_at(idx)
    return unless found

    prev = found.prev
    return unless prev

    node = Node.new(value)

    node.prev = prev
    node.next = found
    found.prev = node
    prev.next = node
  end

  # O(n)
  def replace_at(idx, value)
    found = find_at(idx)
    return unless found

    prev = found.prev
    return unless prev

    node = Node.new(value)

    prev.next = node
    node.prev = prev
    node.next = found.next
    found.next.prev = node
  end

  # O(n)
  def find_at(idx)
    current = @head

    idx.times do
      current = current.next
      return unless current
    end

    current
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

class DoublyLinkedListTest < Test::Unit::TestCase
  def test_add_left
    list = DoublyLinkedList.new

    list.add_left(1)
    list.add_left(2)
    list.add_left(3)
    list.add_left(4)

    assert_equal([4, 3, 2, 1], list.to_a)
  end

  def test_add_right
    list = DoublyLinkedList.new

    list.add_right(1)
    list.add_right(2)
    list.add_right(3)
    list.add_right(4)

    assert_equal([1, 2, 3, 4], list.to_a)
  end

  def test_add_mixed
    list = DoublyLinkedList.new

    list.add_left(1)
    list.add_right(2)
    list.add_left(3)
    list.add_right(4)

    assert_equal([3, 1, 2, 4], list.to_a)
  end

  def test_find_at
    list = DoublyLinkedList.new

    list.add_right(1)
    list.add_right(2)
    list.add_right(3)
    list.add_right(4)

    assert_equal(3, list.find_at(2).value)
    assert_equal(nil, list.find_at(99))
  end

  def test_add_at
    list = DoublyLinkedList.new

    list.add_right(1)
    list.add_right(2)
    list.add_right(3)
    list.add_right(4)

    list.add_at(2, 42)
    list.add_at(99, 101) # should not add

    assert_equal([1, 2, 42, 3, 4], list.to_a)
  end

  def test_remove_left
    list = DoublyLinkedList.new

    list.add_right(1)
    list.add_right(2)
    list.add_right(3)
    list.add_right(4)

    list.remove_left

    assert_equal([2, 3, 4], list.to_a)
  end

  def test_remove_right
    list = DoublyLinkedList.new

    list.add_right(1)
    list.add_right(2)
    list.add_right(3)
    list.add_right(4)

    list.remove_right

    assert_equal([1, 2, 3], list.to_a)
  end

  def test_remove_at
    list = DoublyLinkedList.new

    list.add_right(1)
    list.add_right(2)
    list.add_right(3)
    list.add_right(4)

    list.remove_at(2)

    assert_equal([1, 2, 4], list.to_a)
  end

  def test_replace_at
    list = DoublyLinkedList.new

    list.add_right(1)
    list.add_right(2)
    list.add_right(3)
    list.add_right(4)

    list.replace_at(2, 42)

    assert_equal([1, 2, 42, 4], list.to_a)
  end
end
