package sorting

// go mod init sorting
// go mod tidy

import (
	"testing"
  "github.com/stretchr/testify/assert"
)

type Node struct {
	Value *int
	Next  *Node
}

// Splits a given node into two sublists at the given number of steps
func split(node *Node, steps int) (*Node, *Node) {
  pointer := node
  var head *Node

  for i := 0; i < steps; i++ {
    if pointer == nil {
      return node, nil
    }

    head = pointer
    pointer = pointer.Next
  }

  var tail *Node

  if head != nil {
    tail = head.Next
    head.Next = nil
  }

  return node, tail
}

// Takes two nodes and merges them into one sorted node.
// Sorting is made by comparing the first element of each node.
func merge(left *Node, right *Node) *Node {
  acc := &Node{}
  pointer := acc

  for left != nil && right != nil {
    if *left.Value < *right.Value {
      pointer.Next = left
      left = left.Next
    } else {
      pointer.Next = right
      right = right.Next
    }

    pointer = pointer.Next
  }

  if left != nil {
    pointer.Next = left
  } else if right != nil {
    pointer.Next = right
  }

  return acc.Next
}

// Sorts a given node by splitting it into sublists at the given number of steps,
// then merge them
func sortPass(node *Node, steps int) *Node {
  acc := &Node{}
  pointer := acc

  for node != nil {
    left, remaining := split(node, steps)

    if remaining == nil {
      pointer.Next = left
      break
    }

    right, next := split(remaining, steps)
    merged := merge(left, right)

    pointer.Next = merged

    for pointer.Next != nil {
      pointer = pointer.Next
    }

    node = next
  }

  return acc.Next
}

// Sorts a given node applying a merge sort algorithm,
// using a bottom-up approach (iterative) on a singly linked list
func sort(node *Node) *Node {
  acc := node
  steps := 1

  for node != nil {
    acc = sortPass(acc, steps)
    steps *= 2

    node = node.Next
  }

  return acc
}

// TESTING HELPER FUNCTIONS

func newNode(value int) *Node {
	return &Node{Value: &value}
}

func buildLinkedList(values []int) *Node {
  var head *Node
  var tail *Node

  for _, value := range values {
    if head == nil {
      head = newNode(value)
      tail = head
    } else {
      tail.Next = newNode(value)
      tail = tail.Next
    }
  }

  return head
}

func assertNodeIsSorted(t *testing.T, node *Node) {
  var previous *int

  for node != nil {
    if previous != nil {
      assert.True(t, *previous <= *node.Value)
    }

    previous = node.Value
    node = node.Next
  }
}

// TESTING FUNCTIONS

func TestSplitEmptyNode(t *testing.T) {
	head, tail := split(&Node{}, 1)

	assert.Nil(t, head.Value)
	assert.Nil(t, head.Next)
	assert.Nil(t, tail)
}

func TestSplitNodeIntoOneStep(t *testing.T) {
  node := buildLinkedList([]int{4, 2, 3})
	head, tail := split(node, 1)

	assert.Equal(t, 4, *head.Value)
	assert.Nil(t, head.Next)

	assert.Equal(t, 2, *tail.Value)
	assert.Equal(t, 3, *tail.Next.Value)
	assert.Nil(t, tail.Next.Next)
}

func TestSplitNodeIntoTwoSteps(t *testing.T) {
  node := buildLinkedList([]int{4, 2, 3})
	head, tail := split(node, 2)

  assert.Equal(t, 4, *head.Value)
  assert.Equal(t, 2, *head.Next.Value)
  assert.Nil(t, head.Next.Next)

  assert.Equal(t, 3, *tail.Value)
  assert.Nil(t, tail.Next)
}

func TestMergeEmptyNodes(t *testing.T) {
  merged := merge(nil, nil)

  assert.Nil(t, merged)
}

func TestMergeNodes(t *testing.T) {
  left := buildLinkedList([]int{1, 3})
  right := buildLinkedList([]int{2, 4})

  merged := merge(left, right)

  assert.Equal(t, 1, *merged.Value)
  assert.Equal(t, 2, *merged.Next.Value)
  assert.Equal(t, 3, *merged.Next.Next.Value)
  assert.Equal(t, 4, *merged.Next.Next.Next.Value)
  assert.Nil(t, merged.Next.Next.Next.Next)
}

func TestSortPassIntoOneStep(t *testing.T) {
  node := buildLinkedList([]int{4, 3, 2, 1})
	sorted := sortPass(node, 1)

  assert.Equal(t, 3, *sorted.Value)
  assert.Equal(t, 4, *sorted.Next.Value)
  assert.Equal(t, 1, *sorted.Next.Next.Value)
  assert.Equal(t, 2, *sorted.Next.Next.Next.Value)
  assert.Nil(t, sorted.Next.Next.Next.Next)
}

func TestSortPassIntoTwoSteps(t *testing.T) {
  node := buildLinkedList([]int{4, 3, 2, 1})
	sorted := sortPass(node, 2)

  assert.Equal(t, 2, *sorted.Value)
  assert.Equal(t, 1, *sorted.Next.Value)
  assert.Equal(t, 4, *sorted.Next.Next.Value)
  assert.Equal(t, 3, *sorted.Next.Next.Next.Value)
  assert.Nil(t, sorted.Next.Next.Next.Next)
}

func TestSort(t *testing.T) {
  // Nil
  sorted := sort(nil)
  assert.Nil(t, sorted)

  // One element
  sorted = sort(newNode(1))
  assert.Equal(t, 1, *sorted.Value)
  assert.Nil(t, sorted.Next)

  // Multiple elements
  node := buildLinkedList([]int{3, 2})
  assertNodeIsSorted(t, sort(node))

  node = buildLinkedList([]int{3, 2, 1})
  assertNodeIsSorted(t, sort(node))

  node = buildLinkedList([]int{4, 3, 6, 1, 2, 5, 8, 7})
  assertNodeIsSorted(t, sort(node))
}

