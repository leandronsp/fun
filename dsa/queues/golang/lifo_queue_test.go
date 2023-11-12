package queues

import (
	"internal/safefilepath"
	"testing"

	"github.com/stretchr/testify/assert"
)

type LIFOQueue struct {
  Stack []int
  AmortizedStack []int
}

func (queue *LIFOQueue) Enqueue(element int) {
  queue.Stack = append(queue.Stack, element)
}

func (queue *LIFOQueue) Dequeue() *int {
  if len(queue.Stack) == 0 && len(queue.AmortizedStack) == 0 {
    return nil
  }

  // Move from Stack to AmortizedStack
  // It's an amortized O(1) operation
  for len(queue.Stack) > 0 {
    // Pop from Stack
    element := queue.Stack[len(queue.Stack) - 1]
    queue.Stack = queue.Stack[:len(queue.Stack) - 1]

    // Push to AmortizedStack
    queue.AmortizedStack = append(queue.AmortizedStack, element)
  }

  // Pop from AmortizedStack
  element := queue.AmortizedStack[len(queue.AmortizedStack) - 1]
  queue.AmortizedStack = queue.AmortizedStack[:len(queue.AmortizedStack) - 1]

  return &element
}

func TestLIFOQueue(t *testing.T) {
  queue := LIFOQueue{}

  queue.Enqueue(1)
  queue.Enqueue(2)
  queue.Enqueue(3)

  assert.Equal(t, 1, *queue.Dequeue())
  assert.Equal(t, 2, *queue.Dequeue())
  assert.Equal(t, 3, *queue.Dequeue())
  assert.Nil(t, queue.Dequeue())
}
