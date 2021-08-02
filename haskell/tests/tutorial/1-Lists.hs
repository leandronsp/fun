import Test.HUnit

import Data.List
import Data.Tuple

testLists = TestCase $
  do
    assertEqual "listSize" (length [42, 13, 22]) 3
    assertEqual "sortList" (sort [42, 13, 22]) [13, 22, 42]
    assertEqual "sortListOfStr" (sort "leandro") "adelnor"
    assertEqual "headOfLinkedList" (head [1, 2, 3]) 1
    assertEqual "tailOfLinkedList" (tail [1, 2, 3]) [2, 3]
    assertEqual "consSugar" ("a" : "b" : []) ["a", "b"]
    assertEqual "consSugarJoin" (1 : [2, 3]) [1, 2, 3]
    assertEqual "charsList" ('a' : 'b' : []) "ab"
    assertEqual "firstOfTuple" (fst (42, "leandro")) 42

tests = TestList [TestLabel "testLists" testLists]
