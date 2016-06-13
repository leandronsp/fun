require 'pry-byebug'

# O(nlogn)
class MergeSort
  ALPHABET_MAP = { a: 1, b: 2, c: 3, d: 4, e: 5, f: 6, g: 7, h: 8, i: 9, j: 10, k: 11, l: 12, m: 13, n: 14, o: 15, p: 16, q: 17, r: 18, s: 19, t: 20, u: 21, v: 22, x: 23, w: 24, y: 25, z: 26 }

  def sort!(array)
    sort(array, 0, array.length)
  end

  private

  def sort(array, start, ending)
    quantity = ending - start
    return if quantity <= 1

    pivot = (start + ending) / 2

    sort(array, start, pivot)
    sort(array, pivot, ending)

    merge(array, start, pivot, ending)
  end

  def merge(array, start, pivot, ending)
    result = []
    current = 0
    one     = start
    other   = pivot

    while one < pivot && other < ending do
      one_first_letter = array[one].downcase[0].to_sym
      other_first_letter = array[other].downcase[0].to_sym

      if ALPHABET_MAP[one_first_letter] < ALPHABET_MAP[other_first_letter]
        result[current] = array[one]
        one += 1
      else
        result[current] = array[other]
        other += 1
      end

      current += 1
    end

    while one < pivot do
      result[current] = array[one]
      one += 1
      current += 1
    end

    while other < ending do
      result[current] = array[other]
      other += 1
      current += 1
    end

    for idx in (0...current) do
      array[start + idx] = result[idx]
      idx += 1
    end
  end

end
