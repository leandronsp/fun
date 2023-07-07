require 'test/unit'
require 'byebug'

# Splits a given node into two sublists at the given number of steps
def split(node, steps)
  pointer = node
  head = nil

  steps.times do
    return [node, nil] unless pointer

    head = pointer
    pointer = pointer[1]
  end

  if head
    tail = head[1]
    head[1] = nil
  end

  [node, tail]
end

# Takes two nodes and merges them into one sorted node.
# Sorting is made by comparing the first element of each node.
def merge(left, right)
  acc = [nil, nil]
  pointer = acc

  while left && right
    if left[0] <= right[0]
      pointer[1] = left
      left = left[1]
    else
      pointer[1] = right
      right = right[1]
    end

    pointer = pointer[1]
  end

  pointer[1] = left || right
  acc[1]
end

# Sorts a given node by splitting it into sublists at the given number of steps,
# then merge them
def sort_pass(node, steps)
  acc = [nil, nil]
  pointer = acc

  while node
    left, remaining = split(node, steps)

    if remaining.nil?
      pointer[1] = left
      break
    end

    right, node = split(remaining, steps)

    merged = merge(left, right)

    pointer[1] = merged
    pointer = tail(merged)
  end

  acc[1]
end

# Returns the tail of a given node
def tail(node)
  while node && node[1]
    node = node[1]
  end

  node
end

# Returns the length of a given node
def length(node)
  count = 0

  until node.nil?
    node = node[1]
    count += 1
  end

  count
end

# Sorts a given node applying a merge sort algorithm,
# using a bottom-up approach (iterative) on a singly linked list
def sort(node)
  return node if node.nil? || node[1].nil?

  steps = 1
  length = length(node)

  while steps < length
    node = sort_pass(node, steps)
    steps *= 2
  end

  node
end

class MergeSortIterativeTest < Test::Unit::TestCase
  def test_split_empty_node
    head, tail = split([nil, nil], 1)

    assert_equal([nil, nil], head)
    assert_equal(nil, tail)
  end

  def test_split_node_into_one_step
    head, tail = split([4, [2, [3, nil]]], 1)

    assert_equal([4, nil], head)
    assert_equal([2, [3, nil]], tail)
  end

  def test_split_node_into_two_steps
    head, tail = split([4, [2, [3, nil]]], 2)

    assert_equal([4, [2, nil]], head)
    assert_equal([3, nil], tail)
  end

  def test_merge
    assert_equal([1, [2, nil]], merge([1, nil], [2, nil]))
    assert_equal([1, [2, [3, nil]]], merge([1, nil], [2, [3, nil]]))
  end

  def test_sort_pass_into_one_step
    assert_equal([3, [4, [1, [2, nil]]]], sort_pass([4, [3, [2, [1, nil]]]], 1))
    assert_equal([2, [4, [3, nil]]], sort_pass([4, [2, [3, nil]]], 1))
  end

  def test_sort_pass_into_two_steps
    assert_equal([2, [1, [4, [3, nil]]]], sort_pass([4, [3, [2, [1, nil]]]], 2))
  end

  def test_sort
    assert_equal(nil, sort(nil))
    assert_equal([1, nil], sort([1, nil]))
    assert_equal([1, [2, [3, [4, [5, [6, [7, [8, nil]]]]]]]], sort([4, [6, [3, [2, [5, [1, [8, [7, nil]]]]]]]]))
    assert_equal([1, [2, [3, [4, [5, nil]]]]], sort([4, [3, [2, [1, [5, nil]]]]]))
    assert_equal([1, [2, [3, [4, nil]]]], sort([4, [3, [2, [1, nil]]]]))
    assert_equal([2, [3, [4, nil]]], sort([4, [2, [3, nil]]]))
    assert_equal([2, [3, nil]], sort([3, [2, nil]]))
  end
end
