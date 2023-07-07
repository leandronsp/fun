package main

import "fmt"

func enqueue(queue []int, element int) []int {
  queue = append(queue, element)
  return queue
}

func dequeue(queue []int) (*int, []int) {
  if len(queue) == 0 {
    return nil, queue
  }

  element := queue[0]
  tail := queue[1:]

  return &element, tail
}

func main() {
  var queue []int

  queue = enqueue(queue, 1)
  queue = enqueue(queue, 2)
  queue = enqueue(queue, 3)

  for {
    if element, newQueue := dequeue(queue); element != nil {
      fmt.Println(*element)
      queue = newQueue
    } else {
      break
    }
  }

  queue = enqueue(queue, 4)

  element, _ := dequeue(queue)
  fmt.Println(*element)
}
