defmodule BasicTypesTest do
  use ExUnit.Case

  test "operator `/` always returns a float" do
    assert(10 / 2) == 5.0
  end

  test "`div` function returns integer" do
    assert div(10, 2) == 5
  end

  test "`rem` function returns integer" do
    assert rem(10, 3) == 1
  end

  test "true/false are atoms" do
    assert is_atom(true) == true
    assert is_atom(false) == true
    assert is_boolean(true) == true
    assert is_boolean(false) == true
  end

  test "string interpolation" do
    name = "Leandro"
    assert "Hello, #{name}" == "Hello, Leandro"
  end

  test "anonymous funcions are clojures and do not affect environment" do
    name = "First"

    add = fn(a, b) ->
      name = "Second"
      a + b
    end

    assert add.(2, 3) == 5
    assert name == "First"
  end

  test "`Lists` are like linked lists" do
    list = [1 | [2 | [3 | []]]]
    assert list == [1, 2, 3]
    assert length(list) == 3
  end

  test "`Tuples` are like arrays" do
    tuple = { "1", "2", "3" }
    assert tuple_size(tuple) == 3
    assert elem(tuple, 1) == "2"
  end
end
