import Test.HUnit

testVariables = TestCase $
  do
    let x = 4
    assertEqual "bind x = 4" x 4
    let result = let y = 4 in y * y
    assertEqual "expression and body makes result = 16" result 16

tests = TestList [TestLabel "testVariables" testVariables]
