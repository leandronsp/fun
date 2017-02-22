require 'pry-byebug'

# O(nlogn)
class QuickSortLinkedList
  def sort(list)
    return list if list.length <= 1

    pivot = list.get(0).element
    list.remove(0)

    smaller, larger = partition(pivot, list, LinkedList.new, LinkedList.new)
    append(sort(smaller), pivot, sort(larger))
  end

  private

  def append(left, pivot, right)
    left.add(pivot)

    for idx in (0..right.length) do
      left.add(right.get(idx).element) if right.get(idx)
    end

    left
  end

  def partition(pivot, tail, smaller, larger)
    current = tail.get(0)
    return [smaller, larger] if tail.length < 1

    tail.remove(0)

    if current && current.element <= pivot
      smaller.add_into_beginning(current.element)
    else
      larger.add_into_beginning(current.element)
    end

    partition(pivot, tail, smaller, larger)
  end
end
