require 'pry-byebug'

# O(logn)
class BinarySearch
  ALPHABET_MAP = { a: 1, b: 2, c: 3, d: 4, e: 5, f: 6, g: 7, h: 8, i: 9, j: 10, k: 11, l: 12, m: 13, n: 14, o: 15, p: 16, q: 17, r: 18, s: 19, t: 20, u: 21, v: 22, x: 23, w: 24, y: 25, z: 26 }

  def search(array, term)
    binary_search array, 0, array.length, term
  end

  private

  def binary_search(array, start, ending, term)
    return nil if start > ending

    pivot = (start + ending) / 2

    return nil unless array[pivot]

    pivot_first_letter = array[pivot].downcase[0].to_sym
    term_first_letter = term.downcase[0].to_sym

    return array[pivot] if ALPHABET_MAP[term_first_letter] == ALPHABET_MAP[pivot_first_letter]

    if ALPHABET_MAP[term_first_letter] < ALPHABET_MAP[pivot_first_letter]
      return binary_search(array, start, pivot - 1, term)
    end

    binary_search(array, pivot + 1, ending, term)
  end
end
