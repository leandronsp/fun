module Tutorial.Tests.Basic where
import Test.HUnit

tests = TestCase $
  do
    assertEqual "basicSum" (1 + 1) 2
    assertEqual "basicStr" "leandro" "leandro"
    assertEqual "divisionReturnsInteger" (10 / 2) 5
    assertEqual "divisionReturnsFractionalToo" (10 / 2) 5.0
    assertEqual "concatenatingTwoStrings" ("lean" ++ "dro") "leandro"
