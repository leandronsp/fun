package main

import "fmt"

func push(stack []int, element int) []int {
  stack = append(stack, element)
  return stack
}

func pop(stack []int) (*int, []int) {
  if len(stack) == 0 {
    return nil, stack
  }

  element := stack[len(stack) - 1]
  tail := stack[:len(stack) - 1]

  return &element, tail
}

func main() {
  var stack []int

  stack = push(stack, 1)
  stack = push(stack, 2)
  stack = push(stack, 3)

  for {
    if element, newStack := pop(stack); element != nil {
      fmt.Println(*element)
      stack = newStack
    } else {
      break
    }
  }

  stack = push(stack, 4)

  element, _ := pop(stack)
  fmt.Println(*element)
}
