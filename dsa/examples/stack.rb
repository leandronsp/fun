require_relative 'linked_list'

class Stack
  def initialize
    @list = LinkedList.new
  end

  # O(1)
  def push(element)
    @list.add(element)
  end

  # O(1)
  def pop
    @list.remove(@list.length - 1)
  end

  def peek
    return nil if empty?
    @list.last.element
  end

  # O(1)
  def length
    @list.length
  end

  def empty?
    @list.empty?
  end

  def to_s
    @list.to_s
  end

end
