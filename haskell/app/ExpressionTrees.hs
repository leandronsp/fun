module ExpressionTrees where

import Data.Char

data Token
  = PlusToken
  | TimesToken
  | OpenToken
  | CloseToken
  | IntToken Int
  deriving (Show)

lexer :: String -> [Token]
lexer []                = []
lexer ('+' : remaining) = PlusToken  : lexer remaining
lexer ('*' : remaining) = TimesToken : lexer remaining
lexer ('(' : remaining) = OpenToken  : lexer remaining
lexer (')' : remaining) = CloseToken : lexer remaining

lexer (character : remaining)
  | isSpace character
  = lexer remaining
lexer str@(character : remaining)
  | isDigit character
  = IntToken (stringToInt digitStr) : lexer remaining
  where
    (digitStr, remaining) = break (not . isDigit) str

    stringToInt :: String -> Int
    stringToInt = foldl (\acc character -> 10 * acc + digitToInt character) 0
lexer (character : _)
  = error ("lexer: unexpected character: '" ++ show character ++ "'")

data Expr
  = IntLiteral Int
  | Add Expr Expr
  | Mult Expr Expr
