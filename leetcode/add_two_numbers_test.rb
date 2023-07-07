require 'test/unit'
require 'byebug'

require_relative 'lib/add_two_numbers'
require_relative 'lib/list_node'

class AddTwoNumbersTest < Test::Unit::TestCase
  include AddTwoNumbers

  def test_add_two_numbers
    assert_equal(
      to_array(ListNode.new(7, ListNode.new(0, ListNode.new(8)))),
      to_array(add_two_numbers(
        ListNode.new(2, ListNode.new(4, ListNode.new(3))),
        ListNode.new(5, ListNode.new(6, ListNode.new(4)))
      ))
    )

    assert_equal(
      to_array(ListNode.new(0, nil)),
      to_array(add_two_numbers(
        ListNode.new(0, nil),
        ListNode.new(0, nil)
      ))
    )

    assert_equal(
      to_array(ListNode.new(8, ListNode.new(9, ListNode.new(9, ListNode.new(9, ListNode.new(0, ListNode.new(0, ListNode.new(0, ListNode.new(1))))))))),
      to_array(add_two_numbers(
        ListNode.new(9, ListNode.new(9, ListNode.new(9, ListNode.new(9, ListNode.new(9, ListNode.new(9, ListNode.new(9))))))),
        ListNode.new(9, ListNode.new(9, ListNode.new(9, ListNode.new(9))))
      ))
    )

    assert_equal([7, 0, 4, 0, 1], summation([2, 4, 9], [5, 6, 4, 9]))
    assert_equal([7, 3], summation([0], [7, 3]))
  end
end
