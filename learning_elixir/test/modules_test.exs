defmodule ModulesTest do
  use ExUnit.Case

  defmodule Math do
    def sum(a, b) do
      a + b
    end

    def zero?(0), do: true
    def zero?(x) when is_integer(x), do: false
  end

  test "defmodule" do
    assert Math.sum(1, 2) == 3
    assert Math.zero?(0) == true
    assert Math.zero?(1) == false
  end

  test "function capturing" do
    sum = &Math.sum/2
    assert is_function(sum) == true
    assert sum.(2, 3) == 5
  end

  test "create function shortcut" do
    add_one = &(&1 + 1)
    assert add_one.(3) == 4
  end

  test "function capturing from a module" do
    # could be `&List.flatten(&1, &2)`
    fun = &List.flatten/2
    assert fun.([1, [[2], 3]], [4, 5]) == [1, 2, 3, 4, 5]
  end

  test "default arguments" do
    defmodule Concat do
      def join(a, b, sep \\ " ") do
        a <> sep <> b
      end
    end

    assert Concat.join("leandro", "freitas") == "leandro freitas"
    assert Concat.join("leandro", "freitas", ":") == "leandro:freitas"
  end
end
