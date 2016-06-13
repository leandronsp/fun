defmodule BasicOperatorsTest do
  use ExUnit.Case

  test "`++` and `--` for lists" do
    assert [1, 2] ++ [3] == [1, 2, 3]
    assert [1, 2, 3] -- [2] == [1, 3]
  end

  test "string concatenation `<>`" do
    string = "hello" <> " world"
    assert string == "hello world"
  end

  test "short circuit operators" do
    string = "Leandro"
    result = is_atom(string) and 1
    assert result == false

    result = is_atom(string) or 1
    assert result == 1
  end

  test "comparison" do
    assert 1 == 1.0
    assert 1 === 1
    assert 1 !== 1.0
  end

  test "data types comparison" do
    func = fn a -> a + 1 end
    tuple = { :ok }
    list = [1, { '2' }]
    assert 1 < :atom
    assert :atom < func
    assert func < tuple
    assert tuple < list
  end
end
