require_relative 'linked_list'

class Queue
  def initialize
    @list = LinkedList.new
  end

  # O(1)
  def add(element)
    @list.add(element)
  end

  # O(1)
  def pull
    @list.remove(0)
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
