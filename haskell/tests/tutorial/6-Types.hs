module Tutorial.Tests.Types where
import Test.HUnit

type Point = (Int, Int)

origin :: Point
origin = (0, 0)

moveRight :: Point -> Int -> Point
moveRight (x, y) distance = (x + distance, y)

moveUp :: Point -> Int -> Point
moveUp (x, y) distance = (x, y + distance)

type Colour = String
type ColourPoint = (Int, Int, Colour)

moveColour :: ColourPoint -> Int -> Int -> ColourPoint
moveColour (x, y, colour) xDistance yDistance =
  (x + xDistance, y + yDistance, colour)

tests = TestCase $
  do
    assertEqual "moveRight" (Tutorial.Tests.Types.moveRight (0, 1) 1) (1, 1)
    assertEqual "moveUp" (Tutorial.Tests.Types.moveUp (0, 1) 1) (0, 2)
    assertEqual "moveColour" (Tutorial.Tests.Types.moveColour (0, 1, "green") 1 2) (1, 3, "green")
