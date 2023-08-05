package queues

import (
  "fmt"
  "time"
  "sync"
  "testing"
  "errors"
  "github.com/stretchr/testify/assert"
)

// LinkedList Deque
type Node struct {
  Value int
  Next *Node
  Prev *Node
}

type Deque struct {
  Head *Node
  Tail *Node
}

func (deque *Deque) RPush(value int) {
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

func (deque *Deque) LPush(value int) {
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

func (deque *Deque) RPop() *int {
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

func (deque *Deque) LPop() *int {
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

func (deque *Deque) RPopLPush(other *Deque) *int {
  value := deque.RPop()

  if value == nil {
    return nil
  }

  other.LPush(*value)
  return value
}

func (deque *Deque) ToSlice() []int {
  slice := []int{}

  for node := deque.Head; node != nil; node = node.Next {
    slice = append(slice, node.Value)
  }

  return slice
}

// Blocking Deque
type BlockingDeque struct {
  Store *Deque
  Mutex sync.Mutex
  Emitter *sync.Cond
}

func (deque *BlockingDeque) RPush(value int) {
  deque.Mutex.Lock()
  defer deque.Mutex.Unlock()

  deque.Store.RPush(value)
  deque.Emitter.Signal()
}

func (deque *BlockingDeque) LPush(value int) {
  deque.Mutex.Lock()
  defer deque.Mutex.Unlock()

  deque.Store.LPush(value)
  deque.Emitter.Signal()
}

func (deque *BlockingDeque) BRPop() *int {
  deque.Mutex.Lock()
  defer deque.Mutex.Unlock()

  for deque.Store.Head == nil {
    deque.Emitter.Wait()
  }

  return deque.Store.RPop()
}

func (deque *BlockingDeque) BLPop() *int {
  deque.Mutex.Lock()
  defer deque.Mutex.Unlock()

  for deque.Store.Head == nil {
    deque.Emitter.Wait()
  }

  return deque.Store.LPop()
}

func (deque *BlockingDeque) BRPopLPush(other *BlockingDeque) *int {
  deque.Mutex.Lock()
  defer deque.Mutex.Unlock()

  for deque.Store.Head == nil {
    deque.Emitter.Wait()
  }

  value := deque.Store.RPopLPush(other.Store)
  deque.Emitter.Signal()

  return value
}

func (deque *BlockingDeque) LPop() *int {
  return deque.Store.LPop()
}

func (deque *BlockingDeque) RPop() *int {
  return deque.Store.RPop()
}

func (deque *BlockingDeque) RPopLPush(other *BlockingDeque) {
  deque.Store.RPopLPush(other.Store)
}

func (deque *BlockingDeque) ToSlice() []int {
  return deque.Store.ToSlice()
}

// Worker
type Worker struct {
  TaskQueue *BlockingDeque
  ProcessingQueue *BlockingDeque
  Dlq *BlockingDeque
  Retries map[int]int
}

func NewWorker() *Worker {
  taskQueue := BlockingDeque{Store: &Deque{}}
  taskQueue.Mutex = sync.Mutex{}
  taskQueue.Emitter = sync.NewCond(&taskQueue.Mutex)

  processingQueue := BlockingDeque{Store: &Deque{}}
  processingQueue.Mutex = sync.Mutex{}
  processingQueue.Emitter = sync.NewCond(&processingQueue.Mutex)

  dlq := BlockingDeque{Store: &Deque{}}
  dlq.Mutex = sync.Mutex{}
  dlq.Emitter = sync.NewCond(&dlq.Mutex)

  return &Worker{
    TaskQueue: &taskQueue,
    ProcessingQueue: &processingQueue,
    Dlq: &dlq,
    Retries: map[int]int{},
  }
}

func (worker *Worker) Start() {
  go func() {
    fmt.Println("Worker started. Waiting for tasks...")

    for {
      task := worker.TaskQueue.BRPopLPush(worker.ProcessingQueue)
      err := worker.Process(*task)

      if err != nil {
        fmt.Printf("Task %d failed.\n", *task)

        worker.Retries[*task] = worker.Retries[*task] + 1

        if worker.Retries[*task] > 3 {
          fmt.Printf("Task %d failed too many times. Sending to DLQ.\n", *task)
          worker.ProcessingQueue.RPopLPush(worker.Dlq)
        } else {
          fmt.Printf("Task %d failed. Retrying...\n", *task)
          worker.ProcessingQueue.RPopLPush(worker.TaskQueue)
        }
      }
    }
  }()
}

func (worker *Worker) Process(task int) error {
  fmt.Printf("Processing task %d...\n", task)

  if task == 42 {
    return errors.New("Task failed")
  }

  sleepDuration := task * int(time.Second)
  time.Sleep(time.Duration(sleepDuration))

  worker.ProcessingQueue.LPop()

  fmt.Printf("Task %d processed.\n", task)

  return nil
}

// Testing
func TestBackgroundJob(t *testing.T) {
  worker := NewWorker()

  worker.TaskQueue.RPush(1)
  worker.Start()

  for len(worker.ProcessingQueue.ToSlice()) == 0 {
    time.Sleep(10 * time.Millisecond)
  }

  assert.Equal(t, 1, len(worker.ProcessingQueue.ToSlice()))
  assert.Equal(t, 0, len(worker.TaskQueue.ToSlice()))

  for len(worker.ProcessingQueue.ToSlice()) > 0 {
    time.Sleep(10 * time.Millisecond)
  }

  assert.Equal(t, 0, len(worker.ProcessingQueue.ToSlice()))
  assert.Equal(t, 0, len(worker.TaskQueue.ToSlice()))

  worker.TaskQueue.LPush(42)

  for len(worker.Dlq.ToSlice()) == 0 {
    time.Sleep(10 * time.Millisecond)
  }

  assert.Equal(t, 0, len(worker.ProcessingQueue.ToSlice()))
  assert.Equal(t, 0, len(worker.TaskQueue.ToSlice()))
  assert.Equal(t, 1, len(worker.Dlq.ToSlice()))
}
