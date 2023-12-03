require 'test/unit'

class Stack
  def initialize
    @store = []
  end

  def push(value)
    @store.push(value)
  end

  def pop
    @store.pop
  end
end

class StackTest < Test::Unit::TestCase
  def test_stack
    stack = Stack.new

    stack.push(1)
    stack.push(2)
    stack.push(3)

    assert_equal(3, stack.pop)
    assert_equal(2, stack.pop)
    assert_equal(1, stack.pop)

    assert_nil(stack.pop)
  end
end
