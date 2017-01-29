defmodule StructsTest do
  use ExUnit.Case

  defmodule User do
    defstruct name: "Leandro", age: 29
  end

  test "structs" do
    user_a = %User{}
    assert user_a.name == "Leandro"

    user_b = %User{name: "Gustavo", age: 4}
    assert user_b.name == "Gustavo"
    assert user_b.age == 4

    # updating a struct (acts like a map)
    user_a = %{user_a | name: "Fomps"}
    assert user_a.name == "Fomps"
  end

  test "structs are bare maps" do
    user = %User{}
    assert is_map(user) == true
    assert Map.keys(user) == [:__struct__, :age, :name]
    assert Map.get(user, :name) == "Leandro"
  end

  test "structs do not enumerate as a map" do
    message = "function StructsTest.User.fetch/2 is undefined (StructsTest.User does not\
 implement the Access behaviour)"

    assert_raise UndefinedFunctionError, message, fn ->
      %User{}[:name]
    end
  end
end
