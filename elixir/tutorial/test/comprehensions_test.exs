defmodule ComprehensionsTest do
  use ExUnit.Case

  test "simple square" do
    result = for n <- 1..3, do: n * n
    assert result == [1, 4, 9]
  end

  test "generating a map instead" do
    result = for n <- 1..3, into: %{}, do: {"Square of #{n}", n * n}
    assert result["Square of 1"] == 1
    assert result["Square of 2"] == 4
    assert result["Square of 3"] == 9
  end

  test "with pattern matching and filter" do
    multiple_of_3? = &(rem(&1, 3) == 0)
    values = [good: 1, bad: 2, good: 3, good: 4, bad: 5, good: 6]
    result = for {:good, n} <- values, multiple_of_3?.(n), do: n * n
    assert result == [9, 36]
  end

  test "cartesian product" do
    result = for i <- [:a, :b, :c], j <- [1, 2], do: {i, j}
    assert result == [a: 1, a: 2, b: 1, b: 2, c: 1, c: 2]
  end
end
