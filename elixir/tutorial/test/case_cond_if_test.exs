defmodule CaseCondIfTest do
  use ExUnit.Case

  def do_case(input) do
    case input do
      {1, 2, 3} ->
        "Match!"
      {4, x, 6} ->
        x
      {7, x, 9} when x == 8 ->
        "Eight!"
      {7, x, 9} when x != 8 ->
        "Not Eight!"
      _ ->
        "Any"
    end
  end

  def do_cond(exp) do
    cond do
      exp > 0 -> "gt zero"
      exp < 0 -> "lt zero"
      true -> exp
    end
  end

  test "case" do
    assert do_case({1, 2, 3}) == "Match!"
    assert do_case({4, 5, 6}) == 5
    assert do_case({7, 8, 9}) == "Eight!"
    assert do_case({7, 'fomps', 9}) == "Not Eight!"
    assert do_case({7, 'fomps', 10}) == "Any"
    assert do_case("Fomps") == "Any"
  end

  test "guards" do
    func = fn
      x, y when x > 0 -> x + y
      x, y -> x * y
    end

    assert func.(3, 3) == 6
    assert func.(-3, 3) == -9
  end

  test "conds" do
    assert do_cond(10) == "gt zero"
    assert do_cond(-10) == "lt zero"
    assert do_cond(0) == 0
  end

  test "if, unless" do
    result = if 1 == 1 do
      "A"
    else
      "B"
    end

    assert result == "A"

    result = if 1 == 1, do: "C", else: "T"
    assert result == "C"

    result = if 1 != 1, do: "C", else: "T"
    assert result == "T"
  end

end
