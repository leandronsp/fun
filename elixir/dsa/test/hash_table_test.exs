defmodule HashTableTest do
  use ExUnit.Case
  doctest HashTable

  test "hash table" do
    hash =
    HashTable.insert({}, "name", "Leandro")
    |> HashTable.insert("age", 42)

    assert tuple_size(hash) == 418
    assert HashTable.get(hash, "name") == "Leandro"
    assert HashTable.get(hash, "age") == 42
  end
end
