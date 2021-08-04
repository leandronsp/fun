module Tests.Suite where

import Test.HUnit
import Tutorial.Tests.Basic
import Tutorial.Tests.Lists
import Tutorial.Tests.Variables
import Tutorial.Tests.Functions
import Tutorial.Tests.PatternMatching
import Tutorial.Tests.Modules
import Tutorial.Tests.Types

tests = TestList [
  TestLabel "basicTests" Tutorial.Tests.Basic.tests,
  TestLabel "listsTest" Tutorial.Tests.Lists.tests,
  TestLabel "variablesTest" Tutorial.Tests.Variables.tests,
  TestLabel "functionsTest" Tutorial.Tests.Functions.tests,
  TestLabel "patternMatchingTest" Tutorial.Tests.PatternMatching.tests,
  TestLabel "modulesTest" Tutorial.Tests.Modules.tests,
  TestLabel "typesTest" Tutorial.Tests.Types.tests]
