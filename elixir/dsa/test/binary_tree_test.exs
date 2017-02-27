defmodule BinaryTreeTest do
  use ExUnit.Case
  doctest BinaryTree

  test "multiple insert" do
    tree =
    BinaryTree.empty()
    |> BinaryTree.insert("Jim", "elixir")
    |> BinaryTree.insert("Mark", "ruby")
    |> BinaryTree.insert("Wilson", "java")
    |> BinaryTree.insert("Kevin", "php")
    |> BinaryTree.insert("Anita", "javascript")

    assert tree ==
      {:node, {"Jim", "elixir",
        {:node, {"Anita", "javascript", {:node, nil}, {:node, nil}}},
        {:node, {"Mark", "ruby",
          {:node, {"Kevin", "php", {:node, nil}, {:node, nil}}},
          {:node, {"Wilson", "java", {:node, nil}, {:node, nil}}}
        }}
      }}
  end

  test "search across tree" do
    tree =
    BinaryTree.empty()
    |> BinaryTree.insert("Jim", "elixir")
    |> BinaryTree.insert("Mark", "ruby")
    |> BinaryTree.insert("Wilson", "java")
    |> BinaryTree.insert("Kevin", "php")
    |> BinaryTree.insert("Anita", "javascript")

    assert BinaryTree.search(tree, "Jim")    == "elixir"
    assert BinaryTree.search(tree, "Mark")   == "ruby"
    assert BinaryTree.search(tree, "Wilson") == "java"
    assert BinaryTree.search(tree, "Kevin")  == "php"
    assert BinaryTree.search(tree, "Anita")  == "javascript"
    assert BinaryTree.search(tree, "None")   == nil
  end

  test "iterative invert" do
    tree =
    BinaryTree.empty()
    |> BinaryTree.insert("Jim", "elixir")
    |> BinaryTree.insert("Mark", "ruby")
    |> BinaryTree.insert("Wilson", "java")
    |> BinaryTree.insert("Kevin", "php")
    |> BinaryTree.insert("Anita", "javascript")

    assert BinaryTree.invert(tree) ==
      {:node, {"Jim", "elixir",
        {:node, {"Mark", "ruby",
          {:node, {"Wilson", "java", {:node, nil}, {:node, nil}}},
          {:node, {"Kevin", "php", {:node, nil}, {:node, nil}}}
        }},
        {:node, {"Anita", "javascript", {:node, nil}, {:node, nil}}}
      }}
  end
end
