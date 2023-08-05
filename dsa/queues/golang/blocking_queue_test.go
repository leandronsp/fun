package queues

import (
  "time"
  "sync"
  "testing"
  "github.com/stretchr/testify/assert"
)

type BlockingQueue struct {
  Store []int
  Mutex sync.Mutex
  Emitter *sync.Cond
}

func (queue *BlockingQueue) Enqueue(element int) {
  queue.Mutex.Lock()
  defer queue.Mutex.Unlock()

  queue.Store = append(queue.Store, element)
  queue.Emitter.Signal()
}

func (queue *BlockingQueue) Dequeue() *int {
  queue.Mutex.Lock()
  defer queue.Mutex.Unlock()

  for len(queue.Store) == 0 {
    queue.Emitter.Wait()
  }

  element := queue.Store[0]
  queue.Store = queue.Store[1:]

  return &element
}

func TestBlockingQueue(t *testing.T) {
  queue := BlockingQueue{}
  queue.Mutex = sync.Mutex{}
  queue.Emitter = sync.NewCond(&queue.Mutex)

  queue.Enqueue(1)
  queue.Enqueue(2)
  queue.Enqueue(3)

  assert.Equal(t, 1, *queue.Dequeue())
  assert.Equal(t, 2, *queue.Dequeue())
  assert.Equal(t, 3, *queue.Dequeue())

  // Run in a separate goroutine
  go func() {
    task := queue.Dequeue()
    assert.Equal(t, 4, *task)
  }()

  queue.Enqueue(4)

  for len(queue.Store) > 0 {
    time.Sleep(100 * time.Millisecond)
  }
}
