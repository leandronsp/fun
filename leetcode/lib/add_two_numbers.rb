require_relative 'list_node'
require 'byebug'

module AddTwoNumbers
  # LeetCode 2. Add Two Numbers
  # https://leetcode.com/problems/add-two-numbers/
  # Difficulty: Medium
  # You are given two non-empty linked lists representing two non-negative integers.
  # The digits are stored in reverse order and each of their nodes contain a single digit.
  # Add the two numbers and return it as a linked list.
  # 1. You may assume the two numbers do not contain any leading zero, except the number 0 itself.
  # 2. The digits are stored in reverse order, so that the 1's digit is at the head of the list.

  def to_array(list_node, acc = [])
    return acc if list_node.nil?

    to_array(list_node.next, acc << list_node.val)
  end

  def to_list_node(array, acc = nil)
    return acc if array.empty?

    to_list_node(array[1..-1], ListNode.new(array[0], acc))
  end

  def add_two_numbers(l1, l2)
    upper = to_array(l1)
    lower = to_array(l2)

    result_sum = summation(upper, lower)
    to_list_node(result_sum.reverse)
  end

  def summation(upper, lower)
    result = []

    upper.each_with_index do |upper_n, idx|
      next_idx = idx + 1
      sum = upper_n + (lower[idx] || 0)
      upper[next_idx] = 0 if !upper[next_idx] && lower[next_idx]

      if sum > 9
        result << sum % 10
        upper[next_idx] = upper[next_idx] ? upper[next_idx] + 1 : 1
      else
        result << sum
      end
    end

    result
  end
end
