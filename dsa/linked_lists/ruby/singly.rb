require 'test/unit'
require 'byebug'

class Node
  attr_accessor :value, :next

  def initialize(value)
    @value = value
    @next = nil
  end
end

class SinglyLinkedList
  attr_accessor :head

  # O(1)
  def add_left(value)
    node = Node.new(value)

    if @head.nil?
      @head = node
      return
    end

    node.next = @head
    @head = node
  end

  # O(n)
  def add_right(value)
    node = Node.new(value)

    if @head.nil?
      @head = node
      return
    end

    pointer = @head

    while pointer.next
      pointer = pointer.next
    end

    pointer.next = node
  end

  # O(1)
  def remove_left
    return unless @head

    @head = @head.next
  end

  # O(n)
  def remove_right
    return unless @head

    if @head.next.nil?
      @head = nil
      return
    end

    pointer = @head

    while pointer.next.next
      pointer = pointer.next
    end

    pointer.next = nil
  end

  # O(n)
  def remove_at(idx)
    return remove_left if idx.zero?

    prev = find_at(idx - 1)
    return unless prev

    prev.next = prev.next.next
  end

  # O(n)
  def add_at(idx, value)
    return add_left(value) if idx.zero?

    prev = find_at(idx - 1)
    return unless prev

    node = Node.new(value)
    node.next = prev.next
    prev.next = node
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

class SinglyLinkedListTest < Test::Unit::TestCase
  def test_add_left
    list = SinglyLinkedList.new

    list.add_left(1)
    list.add_left(2)

    assert_equal([2, 1], list.to_a)
  end

  def test_add_right
    list = SinglyLinkedList.new

    list.add_right(1)
    list.add_right(2)

    assert_equal([1, 2], list.to_a)
  end

  def test_find_at
    list = SinglyLinkedList.new

    list.add_right(1)
    list.add_right(2)
    list.add_right(3)
    list.add_right(4)

    assert_equal(3, list.find_at(2).value)
    assert_equal(nil, list.find_at(99))
  end

  def test_add_at
    list = SinglyLinkedList.new

    list.add_right(1)
    list.add_right(2)
    list.add_right(3)
    list.add_right(4)

    list.add_at(2, 42)
    list.add_at(99, 101) # should not add

    assert_equal([1, 2, 42, 3, 4], list.to_a)
  end

  def test_remove_left
    list = SinglyLinkedList.new

    list.add_right(1)
    list.add_right(2)
    list.add_right(3)
    list.add_right(4)

    list.remove_left

    assert_equal([2, 3, 4], list.to_a)
  end

  def test_remove_right
    list = SinglyLinkedList.new

    list.add_right(1)
    list.add_right(2)
    list.add_right(3)
    list.add_right(4)

    list.remove_right

    assert_equal([1, 2, 3], list.to_a)
  end

  def test_remove_at
    list = SinglyLinkedList.new

    list.add_right(1)
    list.add_right(2)
    list.add_right(3)
    list.add_right(4)

    list.remove_at(2)

    assert_equal([1, 2, 4], list.to_a)
  end
end
