defmodule AmortizedQueue do
  defstruct primary: [], amortized: []

  def new, do: %AmortizedQueue{}

  # O(1)
  def enqueue(queue, element) do
    %AmortizedQueue{
      primary: [element | queue.primary],
      amortized: queue.amortized
    }
  end

  # O(n) -> O(1) amortized
  def dequeue(%AmortizedQueue{primary: [], amortized: []}) do
    {nil, %AmortizedQueue{}}
  end

  def dequeue(%AmortizedQueue{primary: primary, amortized: [head | tail]}) do
    {head, %AmortizedQueue{primary: primary, amortized: tail}}
  end

  def dequeue(%AmortizedQueue{primary: primary, amortized: []}) do
    dequeue(%AmortizedQueue{primary: [], amortized: reverse(primary, [])})
  end

  defp reverse([], acc), do: acc
  defp reverse([head | tail], acc), do: reverse(tail, [head | acc])
end

queue = AmortizedQueue.new
queue = AmortizedQueue.enqueue(queue, 1)
queue = AmortizedQueue.enqueue(queue, 2)
queue = AmortizedQueue.enqueue(queue, 3)

{element, queue} = AmortizedQueue.dequeue(queue)
IO.inspect(element)

{element, queue} = AmortizedQueue.dequeue(queue)
IO.inspect(element)

{element, _} = AmortizedQueue.dequeue(queue)
IO.inspect(element)
