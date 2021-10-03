module Interactivity where

askForNumber = ask

ask = do
  putStrLn "Give me a number (or 0 to stop)"
  input <- getLine
  let number = read input::Int
  performCalculations number 0

performCalculations 0 accSum = do
  putStrLn $ "The sum is: " ++ show accSum
  return []

performCalculations number accSum = do
  rest <- ask
  let list = (number : rest)
  let currentSum = sum list
  performCalculations number currentSum

--ask 0 accSum accProduct = do
--  putStrLn $ "The sum is: " ++ show accSum
--  putStrLn $ "The product is: " ++ show accProduct
--
--ask 1 accSum accProduct = do
--  putStrLn "Give me a number (or 0 to stop)"
--  input <- getLine
--  let number = read input::Int
--  performCalculations number accSum accProduct
--
--performCalculations 0 _ _ = return []
--performCalculations number accSum accProduct = do
--  rest <- doCalculations 1 accSum accProduct
--  let list = (number : rest)
--  let totalSum = sum list
--  let totalProduct = foldl (*) 1 list
--  putStrLn $ "The sum is: " ++ show totalSum
--  putStrLn $ "The product is: " ++ show totalProduct
--  return list
