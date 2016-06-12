defmodule Recursion do
  use ExUnit.Case

  defmodule Math do
    def sum_list([head | tail], acc) do
      sum_list(tail, head + acc)
    end

    def sum_list([], acc), do: acc

    def double_each([head | tail]) do
      [head * 2 | double_each(tail)]
    end

    def double_each([]), do: []
  end

  test "sum list" do
    assert Math.sum_list([1, 2, 3], 0) == 6
  end

  test "double each" do
    assert Math.double_each([1, 2, 3]) == [2, 4, 6]
  end

  test "using Enum" do
    assert Enum.reduce([1, 2, 3], 0, &+/2) == 6
    assert Enum.map([1, 2, 3], &(&1 * 2)) == [2, 4, 6]
  end

end
