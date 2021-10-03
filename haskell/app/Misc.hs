module Misc where

import Data.Char

convertToBool :: String -> [Bool]
convertToBool str = map (not . Data.Char.isUpper) str

countLowers :: String -> Int
countLowers str = length (filter Data.Char.isLower str)

maxOf :: [Int] -> Int
maxOf list = foldr max 0 list

sumOf :: Int -> Int -> Int
sumOf a b = a + b

square :: Int -> Int
square x = x * x

mylength [] = 0
mylength (_ : remaining) = 1 + mylength remaining

fib :: Int -> Int
fib 1 = 1
fib 2 = 1
fib n = fib(n - 2) + fib(n - 1)

multiply :: Int -> Int -> Int
multiply a 1 = a
multiply a b = a + multiply a (b - 1)
