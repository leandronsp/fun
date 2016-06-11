defmodule PatternMatchingTest do
  use ExUnit.Case

  test "`++` and `--` for lists" do
    assert [1, 2] ++ [3] == [1, 2, 3]
    assert [1, 2, 3] -- [2] == [1, 3]
  end

  test "match operator" do
    x = 1
    assert(1 = x) == true

    assert_raise MatchError, "no match of right hand side value: 1", fn ->
      2 = x
    end
  end

  test "destructuring tuples and lists" do
    {a, b, c} = { :ok, 1, "abc" }
    assert a == :ok
    assert b == 1
    assert c == "abc"

    [w, c] = [1, 2]
    assert w == 1
    assert c == 2

    assert_raise MatchError, "no match of right hand side value: [1, 2]", fn ->
      {w, c} = [1, 2]
    end

    {:ok, number} = {:ok, 42}
    assert number == 42

    assert_raise MatchError, "no match of right hand side value: {:no_match, 42}", fn ->
      {:ok, number} = {:no_match, 42}
    end

    [head | tail] = [1, 2, 3]
    assert head == 1
    assert tail == [2, 3]

    assert_raise MatchError, "no match of right hand side value: []", fn ->
      [h | t] = []
    end
  end

  test "prepending to a list" do
    list = [1, 2, 3]
    assert [0 | list] == [0, 1, 2, 3]
  end

  test "variables can be rebound" do
    x = 1
    x = 2
    assert x == 2
  end

  test "pin operator" do
    x = 1

    assert_raise MatchError, "no match of right hand side value: 2", fn ->
      ^x = 2
    end

    {y, ^x} = {2, 1}
    assert y == 2
    assert x == 1
  end
end
