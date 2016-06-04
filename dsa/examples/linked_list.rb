require 'pry-byebug'

class Cell
  attr_reader :element, :next, :previous
  attr_writer :next, :previous

  def initialize(element, next_element)
    @element = element
    @next = next_element
  end
end

class LinkedList
  def initialize
    @first = nil
    @last  = nil
    @total = 0
  end

  # O(1)
  def add_into_beginning(element)
    if @total == 0
      @first = Cell.new(element, @first)
      @last  = @first
    else
      cell = Cell.new(element, @first)
      @first.previous = cell
      @first = cell
    end

    @total += 1
  end

  # O(1)
  def add(element)
    return add_into_beginning(element) if @total == 0

    cell = Cell.new(element, nil)
    @last.next = cell
    cell.previous = @last
    @last = cell
    @total += 1
  end

  # O(1)
  def add_to(position, element)
    return add_into_beginning(element) if @total == 0
    return add(element) if position == @total

    previous = get(position - 1)
    cell = Cell.new(element, previous.next)
    previous.next.previous = cell
    cell.previous = previous
    previous.next = cell
    @total += 1
  end

  # O(n)
  def get(position)
    current = @first

    for i in (0...position) do
      current = current.next
      i += 1
    end

    current
  end

  # O(1)
  def remove_from_beginning
    @first = @first.next
    @total -= 1
    @last = nil if @total == 0
  end

  # O(1)
  def remove_from_end
    return remove_from_beginning if @total == 1

    @last.previous.next = nil
    @last = @last.previous
    @total -= 1
  end

  # O(1)
  def remove(position)
    return remove_from_beginning if position == 0
    return remove_from_end if position == @total - 1

    previous = get(position - 1)
    current  = previous.next

    previous.next = current.next
    current.next.previous = previous

    current.next = nil
    current.previous = nil

    @total -= 1
  end

  # O(n)
  def contains?(element)
    current = @first

    while current != nil do
      return true if current.element == element
      current = current.next
    end

    false
  end

  def length
    @total
  end

  def to_s
    return '[]' if @total == 0

    current = @first

    str = ''

    for i in (0..@total) do
      break unless current
      str += "#{current.element},"
      current = current.next
      i += 1
    end

    str.split(',')
  end
end
