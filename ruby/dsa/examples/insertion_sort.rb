require 'pry-byebug'

# O(n) -> O(n^2)
class InsertionSort
  ALPHABET_MAP = { a: 1, b: 2, c: 3, d: 4, e: 5, f: 6, g: 7, h: 8, i: 9, j: 10, k: 11, l: 12, m: 13, n: 14, o: 15, p: 16, q: 17, r: 18, s: 19, t: 20, u: 21, v: 22, x: 23, w: 24, y: 25, z: 26 }

  def sort!(array)
    for idx in (0...array.length) do
      current_idx = idx

      current_first_letter  = array[current_idx].downcase[0].to_sym
      previous_first_letter = array[current_idx - 1].downcase[0].to_sym

      while ALPHABET_MAP[current_first_letter] < ALPHABET_MAP[previous_first_letter]
        current  = array[current_idx]
        previous = array[current_idx - 1]

        array[current_idx] = previous
        array[current_idx - 1] = current

        current_idx -= 1
        break if current_idx == 0

        current_first_letter  = array[current_idx].downcase[0].to_sym
        previous_first_letter = array[current_idx - 1].downcase[0].to_sym
      end

      idx += 1
    end
  end

end
