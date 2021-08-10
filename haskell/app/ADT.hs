module ADT where

data Status = Inactive | Active | Disabled deriving (Show)
data Person = Person String Status deriving (Show)

changeStatus :: Person -> Status -> Person
changeStatus (Person name _status) newStatus = Person name newStatus

main = do
  print $ (Person "Leandro" Inactive)
      `changeStatus` Active
      `changeStatus` Disabled
