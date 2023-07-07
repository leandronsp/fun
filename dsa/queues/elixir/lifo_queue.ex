defmodule LIFOQueue do
  def new, do: {[], []}

  # O(1)
  def enqueue({primary, amortized}, element), do: push({primary, amortized}, element)

  # O(n) -> O(1) amortized
  def dequeue({[], []}), do: pop({[], []})
  def dequeue({primary, [head | tail]}), do: pop({primary, [head | tail]})
  def dequeue({primary, []}), do: pop({primary, []})

  # O(1)
  defp push({primary, amortized}, element), do: {[element | primary], amortized}

  # O(n) -> O(1) amortized
  defp pop({[], []}), do: {nil, {[], []}}
  defp pop({primary, [head | tail]}), do: {head, {primary, tail}}
  defp pop({primary, []}), do: pop({[], reverse(primary, [])})

  defp reverse([], acc), do: acc
  defp reverse([head | tail], acc), do: reverse(tail, [head | acc])
end

{primary, amortized} = LIFOQueue.new

{primary, amortized} = LIFOQueue.enqueue({primary, amortized}, 1)
{primary, amortized} = LIFOQueue.enqueue({primary, amortized}, 2)
{primary, amortized} = LIFOQueue.enqueue({primary, amortized}, 3)

{element, {primary, amortized}} = LIFOQueue.dequeue({primary, amortized})
IO.inspect(element)

{element, {primary, amortized}} = LIFOQueue.dequeue({primary, amortized})
IO.inspect(element)

{element, {primary, amortized}} = LIFOQueue.dequeue({primary, amortized})
IO.inspect(element)

{primary, amortized} = LIFOQueue.enqueue({primary, amortized}, 4)

{element, {_, _}} = LIFOQueue.dequeue({primary, amortized})
IO.inspect(element)
