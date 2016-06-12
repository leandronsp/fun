defmodule EnumsAndStreamsTest do
  use ExUnit.Case

  test "ranges" do
    assert Enum.to_list(1..3) == [1, 2, 3]
  end

  test "funcions in the Enum module are eager" do
    odd? = &(rem(&1, 2) != 0)
    result = 1..100 |> Enum.map(&(&1 * 3)) |> Enum.filter(odd?) |> Enum.sum
    assert result == 7500
  end

  test "Streams use lazy operations" do
    odd? = &(rem(&1, 2) != 0)
    result = 1..100 |> Stream.map(&(&1 * 3)) |> Stream.filter(odd?) |> Enum.sum
    assert result == 7500
  end
end
