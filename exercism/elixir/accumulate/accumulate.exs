defmodule Accumulate do
  @doc """
    Given a list and a function, apply the function to each list item and
    replace it with the function's return value.

    Returns a list.

    ## Examples

      iex> Accumulate.accumulate([], fn(x) -> x * 2 end)
      []

      iex> Accumulate.accumulate([1, 2, 3], fn(x) -> x * 2 end)
      [2, 4, 6]

  """

  @spec accumulate(list, (any -> any)) :: list
  def accumulate([], _), do: []
  def accumulate([head | tail], fun) do
    do_accumulate(head, tail, fun, [])
  end

  defp do_accumulate(element, [], fun, acc), do: acc ++ [fun.(element)]
  defp do_accumulate(element, [head | tail], fun, acc) do
    do_accumulate(head, tail, fun, acc ++ [fun.(element)])
  end

end
