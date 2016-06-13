require_relative 'vector'
require_relative 'linked_list'

class SimpleSet
  def initialize
    @alphabet_map = { a: 1, b: 2, c: 3, d: 4, e: 5, f: 6, g: 7, h: 8, i: 9, j: 10, k: 11, l: 12, m: 13, n: 14, o: 15, p: 16, q: 17, r: 18, s: 19, t: 20, u: 21, v: 22, x: 23, w: 24, y: 25, z: 26 }
    @array = Vector.new
    build_indices!
  end

  # O(26)
  def build_indices!
    for i in (0..26) do
      @array.add LinkedList.new
    end
  end

  # O(logn)
  def add(element)
    return if contains?(element)
    get_section(element).add(element)
  end

  # O(logn)
  def remove(element)
    get_section(element).remove_element(element)
  end

  def get_section(element)
    @array.get get_index(element)
  end

  def contains?(element)
    get_section(element).contains?(element)
  end

  def get_index(element)
    @alphabet_map[element.downcase[0].to_sym]
  end
  # O(26)
  def length
    size = 0

    for i in (0..26) do
      size +=1 if @array.get(i).length > 0
    end

    size
  end

  def empty?
    length == 0
  end

  def to_s
    @array.to_s
  end
end
