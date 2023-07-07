package main

import "fmt"

type Node struct {
  Value int
  Next *Node
}

type LinkedListQueue struct {
  Head *Node
  Tail *Node
}

func (queue *LinkedListQueue) Enqueue(element int) {
  node := &Node{Value: element}

  if queue.Head == nil {
    queue.Head = node
    queue.Tail = node
  } else {
    queue.Tail.Next = node
    queue.Tail = node
  }
}

func (queue *LinkedListQueue) Dequeue() *int {
  if queue.Head == nil {
    return nil
  }

  node := queue.Head
  queue.Head = node.Next

  if queue.Head == nil {
    queue.Tail = nil
  }

  return &node.Value
}

func main() {
  var element *int

  queue := &LinkedListQueue{}

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
