defmodule LETest do
  use ExUnit.Case
  doctest LE

  test "operator `/` always returns a float" do
    assert(10 / 2) == 5.0
  end

  test "`div` function returns integer" do
    assert div(10, 2) == 5
  end

  test "`rem` function returns integer" do
    assert rem(10, 3) == 1
  end
end
