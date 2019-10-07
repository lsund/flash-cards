module Main where

import Data.List.Split

-- (Question, Answer)
type Card = (String, String)

nCards :: Int
nCards = 5

questionsFile :: FilePath
questionsFile = "/home/lsund/Documents/work/notes/kafka.md"

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
  x <-
    readFile questionsFile >>= \cont -> mapM userQuery $ fileContentToCards cont
  print x
