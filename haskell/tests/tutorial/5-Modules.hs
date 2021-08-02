module ModulesTest where

import Test.HUnit

increment :: Num a => a -> a
increment x = x + 1

maximum :: Ord a => a -> a -> a
maximum x y | x >= y    = x
            | otherwise = y

signum :: (Ord a, Num a) => a -> Int
signum x | x < 0     = -1
         | x == 0    = 0
         | otherwise = 1

circleArea :: Floating a => a -> a
circleArea diameter = Prelude.pi * radius * radius
  where radius = diameter / 2.0

fib :: Int -> Int
fib 1 = 1
fib 2 = 1
fib x = fib (x-1) + fib (x-2)

testModules = TestCase $
  do
    assertEqual "increment" (ModulesTest.increment 42) 43
    assertEqual "maximum" (ModulesTest.maximum 42 44) 44
    assertEqual "signum of > 1" (ModulesTest.signum 12) 1
    assertEqual "signum of 0" (ModulesTest.signum 0) 0
    assertEqual "circle area" (ModulesTest.circleArea 6.0) 28.274333882308138
    assertEqual "fib(1) = 1" (ModulesTest.fib 1) 1
    assertEqual "fib(2) = 1" (ModulesTest.fib 2) 1
    assertEqual "fib(3) = 2" (ModulesTest.fib 3) 2
    assertEqual "fib(4) = 3" (ModulesTest.fib 4) 3
    assertEqual "fib(5) = 5" (ModulesTest.fib 5) 5
    assertEqual "fib(6) = 8" (ModulesTest.fib 6) 8
    assertEqual "fib(7) = 13" (ModulesTest.fib 7) 13
    assertEqual "fib(8) = 21" (ModulesTest.fib 8) 21

tests = TestList [TestLabel "testModules" testModules]
