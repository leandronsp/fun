defmodule KeywordsAndMaps do
  use ExUnit.Case

  test "keyword lists" do
    assert [{:a, 1}, {:b, 2}] == [a: 1, b: 2]

    list = [a: 0, b: 1, c: 2]
    assert list[:a] == 0
  end

  test "maps" do
    map = %{:a => 1, "name" => "Leandro"}
    assert map[:a] == 1
    assert map["name"] == "Leandro"

    assert Map.get(map, :a) == 1
    assert map.a == 1
    assert %{map | :a => 2} == %{:a => 2, "name" => "Leandro"}
  end

  test "nested data structures" do
    users = [
      leandro: %{name: "Leandro", age: 29 },
      gustavo: %{name: "Gustavo", age: 4}
    ]

    assert users[:leandro].age == 29
  end
end
