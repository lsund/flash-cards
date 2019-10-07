module Main where

import Data.List.Split
import System.Environment (getArgs)

-- (Question, Answer)
type Card = (String, String)

nCards :: Int
nCards = 5

fileContentToCards :: String -> [Card]
fileContentToCards =
  map tuplize . take nCards . chunksOf 2 . filter (not . null) . lines
  where
    tuplize [x, y] = (x, y)
    tuplize _ = error "Malformed data"

userQuery :: Card -> IO String
userQuery (question, answer) = do
  putStr $ question ++ " [Enter]"
  _ <- getLine
  putStrLn answer
  putStrLn "Y/n"
  getLine

main :: IO ()
main = do
  score <-
    fmap head getArgs >>= readFile >>= \cont ->
      mapM userQuery $ fileContentToCards cont
  print score
