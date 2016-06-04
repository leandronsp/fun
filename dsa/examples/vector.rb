class Vector
  def initialize
    @array = []
    @next_available_position = 0
  end

  # O(1)
  def add(element)
    @array[@next_available_position] = element
    @next_available_position += 1
  end

  def add_to(position, element)
    raise StandarError unless occupied?(position)
    i = @next_available_position - 1

    # O(n)
    # shift to the right
    while i >= position do
      @array[i + 1] = @array[i]
      i -= 1
    end

    @array[position] = element
    @next_available_position += 1
  end

  def remove(position)
    while position < @next_available_position do
      @array[position] = @array[position + 1]
      position += 1
    end

    @next_available_position -= 1
  end

  def contains(element)
    # O(n)
    for pos in (0..@array.length) do
      return true if element == @array[pos]
    end

    false
  end

  def occupied?(position)
    position >= 0 && position < @next_available_position
  end

  # O(1)
  def get(position)
    raise StandardError unless occupied?(position)
    @array[position]
  end

  def length
    @next_available_position
  end

  def to_s
    @array.map(&:to_s)
  end
end
