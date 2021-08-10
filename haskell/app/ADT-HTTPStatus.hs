module ADT.HTTPStatus where

data StatusCode = StatusCode Int deriving (Show)

ok, created, notFound :: StatusCode

ok       = StatusCode 200
created  = StatusCode 201
notFound = StatusCode 404

main = do
  print $ ok
