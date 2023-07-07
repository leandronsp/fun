defmodule Stack do
  def new, do: []

  # O(1)
  def push(stack, element), do: [element | stack]

  # O(1)
  def pop([]), do: {nil, []}
  def pop([head | tail]), do: {head, tail}
end

stack = Stack.new

stack = Stack.push(stack, 1)
stack = Stack.push(stack, 2)
stack = Stack.push(stack, 3)

{element, stack} = Stack.pop(stack)
IO.inspect(element)

{element, stack} = Stack.pop(stack)
IO.inspect(element)

{element, _} = Stack.pop(stack)
IO.inspect(element)
