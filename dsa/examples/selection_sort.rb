require 'pry-byebug'

# O(n^2)
class SelectionSort
  ALPHABET_MAP = { a: 1, b: 2, c: 3, d: 4, e: 5, f: 6, g: 7, h: 8, i: 9, j: 10, k: 11, l: 12, m: 13, n: 14, o: 15, p: 16, q: 17, r: 18, s: 19, t: 20, u: 21, v: 22, x: 23, w: 24, y: 25, z: 26 }

  def sort!(array)
    for idx in (0...array.length) do
      smaller_idx = search_smaller(array, idx, array.length - 1)

      current = array[idx]
      smaller = array[smaller_idx]
      array[idx] = smaller
      array[smaller_idx] = current

      idx += 1
    end
  end

  # O(n)
  def search_smaller(array, start, stop)
    smaller = start
    current = start

    while current <= stop do
      current_first_letter = array[current].downcase[0].to_sym
      smaller_first_letter = array[smaller].downcase[0].to_sym
      if ALPHABET_MAP[current_first_letter] < ALPHABET_MAP[smaller_first_letter]
        smaller = current
      end
      current += 1
    end

    smaller
  end
end
