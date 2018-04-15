defmodule FibonacciTest do
  use ExUnit.Case
  doctest Fibonacci

  test "nth positions" do
    assert Fibonacci.of_nth(1) == 1
    assert Fibonacci.of_nth(2) == 1
    assert Fibonacci.of_nth(3) == 2
    assert Fibonacci.of_nth(4) == 3
    assert Fibonacci.of_nth(5) == 5
    assert Fibonacci.of_nth(6) == 8
    assert Fibonacci.of_nth(7) == 13
    assert Fibonacci.of_nth(8) == 21
    assert Fibonacci.of_nth(10) == 55

    assert Fibonacci.of_nth(100) == 354224848179261915075
  end
end
