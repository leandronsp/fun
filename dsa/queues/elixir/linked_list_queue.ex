defmodule LinkedListQueue do
  def new, do: {[], []}

  # O(1)
  def enqueue({primary, amortized}, element), do: {[element | primary], amortized}

  # O(n) -> O(1) amortized
  def dequeue({[], []}), do: {nil, {[], []}}
  def dequeue({primary, [head | tail]}), do: {head, {primary, tail}}
  def dequeue({primary, []}), do: dequeue({[], reverse(primary, [])})

  defp reverse([], acc), do: acc
  defp reverse([head | tail], acc), do: reverse(tail, [head | acc])
end

{primary, amortized} = LinkedListQueue.new

{primary, amortized} = LinkedListQueue.enqueue({primary, amortized}, 1)
{primary, amortized} = LinkedListQueue.enqueue({primary, amortized}, 2)
{primary, amortized} = LinkedListQueue.enqueue({primary, amortized}, 3)

{element, {primary, amortized}} = LinkedListQueue.dequeue({primary, amortized})
IO.inspect(element)

{element, {primary, amortized}} = LinkedListQueue.dequeue({primary, amortized})
IO.inspect(element)

{element, {primary, amortized}} = LinkedListQueue.dequeue({primary, amortized})
IO.inspect(element)

{primary, amortized} = LinkedListQueue.enqueue({primary, amortized}, 4)

{element, {_, _}} = LinkedListQueue.dequeue({primary, amortized})
IO.inspect(element)
