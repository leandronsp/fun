package main

import "fmt"

type LIFOQueue struct {
  stack []int
  amortized []int
}

func (queue *LIFOQueue) Enqueue(element int) {
  queue.stack = append(queue.stack, element)
}

func (queue *LIFOQueue) Dequeue() *int {
  if len(queue.stack) == 0 && len(queue.amortized) == 0 {
    return nil
  }

  for len(queue.stack) > 0 {
    // Pop from stack
    element := queue.stack[len(queue.stack) - 1]
    queue.stack = queue.stack[:len(queue.stack) - 1]

    // Push to amortized
    queue.amortized = append(queue.amortized, element)
  }

  // Pop from amortized
  element := queue.amortized[len(queue.amortized) - 1]
  queue.amortized = queue.amortized[:len(queue.amortized) - 1]

  return &element
}

func main() {
  var element *int

  queue := &LIFOQueue{}

  queue.Enqueue(1)
  queue.Enqueue(2)
  queue.Enqueue(3)

  for {
    if element = queue.Dequeue(); element != nil {
      fmt.Println(*element)
    } else {
      break
    }
  }

  queue.Enqueue(4)
  fmt.Println(*queue.Dequeue())
}
