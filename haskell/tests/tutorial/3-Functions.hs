import Test.HUnit

import Data.Char

testFunctions = TestCase $
  do
    let square x = x * x
    assertEqual "square of 4 is 16" (square 4) 16
    assertEqual "mapFunction" (map (+1) [1..5]) [2, 3, 4, 5, 6]
    assertEqual "filterFunction" (filter (>5) [3, 10, 7, 5, 6, 1]) [10, 7, 6]
    let result = let square x = x * x in square 4
    assertEqual "square result of 4 is 16" result 16
    assertEqual "toUpper in a word" (map toUpper "leandro") "LEANDRO"

tests = TestList [TestLabel "testFunctions" testFunctions]
