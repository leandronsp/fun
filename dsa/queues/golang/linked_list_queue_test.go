package queues

import (
  "testing"
  "github.com/stretchr/testify/assert"
)

type Node struct {
  Value int
  Next *Node
}

type LinkedListQueue struct {
  Head *Node
  Tail *Node
}

func (queue *LinkedListQueue) Enqueue(value int) {
  node := Node{Value: value}

  if queue.Tail == nil {
    queue.Tail = &node
    queue.Head = &node
    return
  }

  queue.Tail.Next = &node
  queue.Tail = &node
}

func (queue *LinkedListQueue) Dequeue() *int {
  if queue.Head == nil {
    return nil
  }

  node := queue.Head
  queue.Head = queue.Head.Next

  if queue.Head == nil {
    queue.Tail = nil
  }

  return &node.Value
}

func TestLinkedListQueue(t *testing.T) {
  queue := LinkedListQueue{}

  queue.Enqueue(1)
  queue.Enqueue(2)
  queue.Enqueue(3)

  assert.Equal(t, 1, *queue.Dequeue())
  assert.Equal(t, 2, *queue.Dequeue())
  assert.Equal(t, 3, *queue.Dequeue())
  assert.Nil(t, queue.Dequeue())
}
