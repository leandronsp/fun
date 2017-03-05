defmodule BalancedBinaryTreeTest do
  use ExUnit.Case
  doctest BalancedBinaryTree

  test "insert 2" do
    tree =
    BalancedBinaryTree.empty()
    |> BalancedBinaryTree.insert(1, 1)
    |> BalancedBinaryTree.insert(2, 2)

    assert tree ==
      {:node, {1, 1,
        {:node, nil},
        {:node, {2, 2, {:node, nil}, {:node, nil}}}
      }}
  end

  test "insert 3" do
    tree =
    BalancedBinaryTree.empty()
    |> BalancedBinaryTree.insert(1, 1)
    |> BalancedBinaryTree.insert(2, 2)
    |> BalancedBinaryTree.insert(3, 3)

    assert tree ==
      {:node, {2, 2,
        {:node, {1, 1, {:node, nil}, {:node, nil}}},
        {:node, {3, 3, {:node, nil}, {:node, nil}}}
      }}
  end

  test "insert 4" do
    tree =
    BalancedBinaryTree.empty()
    |> BalancedBinaryTree.insert(1, 1)
    |> BalancedBinaryTree.insert(2, 2)
    |> BalancedBinaryTree.insert(3, 3)
    |> BalancedBinaryTree.insert(4, 4)

    assert tree ==
      {:node, {3, 3,
        {:node, {2, 2,
          {:node, {1, 1, {:node, nil}, {:node, nil}}},
          {:node, nil}
        }},
        {:node, {4, 4, {:node, nil}, {:node, nil}}}
      }}
  end

  test "insert 5" do
    tree =
    BalancedBinaryTree.empty()
    |> BalancedBinaryTree.insert(1, 1)
    |> BalancedBinaryTree.insert(2, 2)
    |> BalancedBinaryTree.insert(3, 3)
    |> BalancedBinaryTree.insert(4, 4)
    |> BalancedBinaryTree.insert(5, 5)

    assert tree ==
      {:node, {3, 3,
        {:node, {2, 2,
          {:node, {1, 1, {:node, nil}, {:node, nil}}},
          {:node, nil}
        }},
        {:node, {4, 4,
          {:node, nil},
          {:node, {5, 5, {:node, nil}, {:node, nil}}}
        }}
      }}
  end

  #test "insert 6" do
  #  tree =
  #  BalancedBinaryTree.empty()
  #  |> BalancedBinaryTree.insert(1, 1)
  #  |> BalancedBinaryTree.insert(2, 2)
  #  |> BalancedBinaryTree.insert(3, 3)
  #  |> BalancedBinaryTree.insert(4, 4)
  #  |> BalancedBinaryTree.insert(5, 5)
  #  |> BalancedBinaryTree.insert(6, 6)

  #  assert tree ==
  #    {:node, {4, 4,
  #      {:node, {2, 2,
  #        {:node, {1, 1, {:node, nil}, {:node, nil}}},
  #        {:node, {3, 3, {:node, nil}, {:node, nil}}}
  #      }},
  #      {:node, {5, 5,
  #        {:node, nil},
  #        {:node, {6, 6, {:node, nil}, {:node, nil}}}
  #      }}
  #    }}
  #end
end
