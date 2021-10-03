module Tutorial.Tests.Misc where
import Test.HUnit
import Data.Char

multiply :: Int -> Int -> Int
multiply a 1 = a
multiply a b = a + multiply a (b - 1)

mymap :: (a -> b) -> [a] -> [b]
mymap func [] = []
mymap func (elem : rest) = func elem : mymap func rest

tests = TestCase $
  do
    assertEqual "9 x 1 = 9" (multiply 9 1) 9
    assertEqual "1 x 9 = 9" (multiply 1 9) 9
    assertEqual "6 x 4 = 24" (multiply 6 4) 24
    assertEqual "10 x 10 = 100" (multiply 10 10) 100
    assertEqual "mymap toUpper []" (mymap toUpper []) []
    assertEqual "mymap toUpper 'leandro'" (mymap toUpper "leandro") "LEANDRO"
    assertEqual "mymap (+1) [1,2,3]" (mymap (+1) [1, 2, 3]) [2, 3, 4]
