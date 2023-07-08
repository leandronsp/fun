defmodule Queue do
  def new, do: []

  # O(1)
  def enqueue(queue, element), do: [element | queue]

  # O(n)
  def dequeue([]), do: {nil, []}
  def dequeue([head]), do: {head, []}
  def dequeue([head | tail]) do
    {first, rest} = dequeue(tail)
    {first, [head | rest]}
  end
end

queue = Queue.new
queue = Queue.enqueue(queue, 1)
queue = Queue.enqueue(queue, 2)
queue = Queue.enqueue(queue, 3)

{element, queue} = Queue.dequeue(queue)
IO.inspect(element)

{element, queue} = Queue.dequeue(queue)
IO.inspect(element)

{element, queue} = Queue.dequeue(queue)
IO.inspect(element)

{element, _} = Queue.dequeue(queue)
IO.inspect(element)
