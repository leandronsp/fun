quicksort :: [Int] -> [Int]

quicksort []      = []
quicksort [pivot] = [pivot]

quicksort (pivot:tail) =
  (quicksort [smaller | smaller <- tail, smaller <= pivot])
    ++ [pivot] ++
  (quicksort [larger | larger <- tail, larger > pivot])
