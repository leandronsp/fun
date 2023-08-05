package queues

import (
  "testing"
  "github.com/stretchr/testify/assert"
)

type Queue struct {
  Store []int
}

func (queue *Queue) Enqueue(element int) {
  queue.Store = append(queue.Store, element)
}

func (queue *Queue) Dequeue() *int {
  if len(queue.Store) == 0 {
    return nil
  }

  element := queue.Store[0]
  queue.Store = queue.Store[1:]

  return &element
}

func TestQueue(t *testing.T) {
  queue := Queue{}

  queue.Enqueue(1)
  queue.Enqueue(2)
  queue.Enqueue(3)

  assert.Equal(t, 1, *queue.Dequeue())
  assert.Equal(t, 2, *queue.Dequeue())
  assert.Equal(t, 3, *queue.Dequeue())
  assert.Nil(t, queue.Dequeue())
}
