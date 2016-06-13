require 'pry-byebug'

# O(nlogn)
class QuickSort
  ALPHABET_MAP = { a: 1, b: 2, c: 3, d: 4, e: 5, f: 6, g: 7, h: 8, i: 9, j: 10, k: 11, l: 12, m: 13, n: 14, o: 15, p: 16, q: 17, r: 18, s: 19, t: 20, u: 21, v: 22, x: 23, w: 24, y: 25, z: 26 }

  def sort!(array)
    sort(array, 0, array.length)
  end

  private

  def sort(array, start, ending)
    quantity = ending - start
    return if quantity <= 1

    pivot = partition(array, start, ending)

    sort(array, start, pivot)
    sort(array, pivot + 1, ending)
  end

  def partition(array, start, ending)
    factor = 0
    pivot = array[ending - 1]

    for idx in (0..ending - 1) do
      current = array[idx]
      current_first_letter = current.downcase[0].to_sym
      pivot_first_letter = pivot.downcase[0].to_sym
      if ALPHABET_MAP[current_first_letter] < ALPHABET_MAP[pivot_first_letter]
        switch(array, idx, factor)
        factor += 1
      end
    end

    switch(array, ending - 1, factor)
    factor
  end

  def switch(array, from, to)
    _to   = array[to]
    _from = array[from]

    array[from] = _to
    array[to]   = _from
  end

end
