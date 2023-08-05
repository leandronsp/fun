package queues

import (
  "testing"
  "github.com/stretchr/testify/assert"
)

type Node struct {
  Value int
  Next *Node
  Prev *Node
}

type LinkedListDeque struct {
  Head *Node
  Tail *Node
}

func (deque *LinkedListDeque) RPush(value int) {
  node := Node{Value: value}

  if deque.Tail == nil {
    deque.Tail = &node
    deque.Head = &node
    return
  }

  node.Prev = deque.Tail
  deque.Tail.Next = &node
  deque.Tail = &node
}

func (deque *LinkedListDeque) LPush(value int) {
  node := Node{Value: value}

  if deque.Head == nil {
    deque.Head = &node
    deque.Tail = &node
    return
  }

  node.Next = deque.Head
  deque.Head.Prev = &node
  deque.Head = &node
}

func (deque *LinkedListDeque) RPop() *int {
  if deque.Tail == nil {
    return nil
  }

  node := deque.Tail
  deque.Tail = deque.Tail.Prev

  if deque.Tail == nil {
    deque.Head = nil
  } else {
    deque.Tail.Next = nil
  }

  return &node.Value
}

func (deque *LinkedListDeque) LPop() *int {
  if deque.Head == nil {
    return nil
  }

  node := deque.Head
  deque.Head = deque.Head.Next

  if deque.Head == nil {
    deque.Tail = nil
  } else {
    deque.Head.Prev = nil
  }

  return &node.Value
}

func (deque *LinkedListDeque) ToSlice() []int {
  slice := []int{}

  for node := deque.Head; node != nil; node = node.Next {
    slice = append(slice, node.Value)
  }

  return slice
}

func TestLinkedListDeque(t *testing.T) {
  deque := LinkedListDeque{}

  deque.RPush(1)
  deque.RPush(2)
  deque.RPush(3)

  assert.Equal(t, []int{1, 2, 3}, deque.ToSlice())

  assert.Equal(t, 3, *deque.RPop())
  assert.Equal(t, 2, *deque.RPop())
  assert.Equal(t, 1, *deque.RPop())
  assert.Nil(t, deque.RPop())

  deque.LPush(1)
  deque.LPush(2)
  deque.LPush(3)

  assert.Equal(t, []int{3, 2, 1}, deque.ToSlice())

  assert.Equal(t, 3, *deque.LPop())
  assert.Equal(t, 2, *deque.LPop())
  assert.Equal(t, 1, *deque.LPop())
  assert.Nil(t, deque.LPop())
}
