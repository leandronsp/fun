defmodule AmortizedQueue do
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

{primary, amortized} = AmortizedQueue.new

{primary, amortized} = AmortizedQueue.enqueue({primary, amortized}, 1)
{primary, amortized} = AmortizedQueue.enqueue({primary, amortized}, 2)
{primary, amortized} = AmortizedQueue.enqueue({primary, amortized}, 3)

{element, {primary, amortized}} = AmortizedQueue.dequeue({primary, amortized})
IO.inspect(element)

{element, {primary, amortized}} = AmortizedQueue.dequeue({primary, amortized})
IO.inspect(element)

{element, {primary, amortized}} = AmortizedQueue.dequeue({primary, amortized})
IO.inspect(element)

{primary, amortized} = AmortizedQueue.enqueue({primary, amortized}, 4)

{element, {_, _}} = AmortizedQueue.dequeue({primary, amortized})
IO.inspect(element)
