module Main where

import Data.List.Split

nCards :: Int
nCards = 5

questionsFile :: FilePath
questionsFile = "/home/lsund/Documents/work/notes/kafka.md"

fileContentToCards :: String -> [(String, String)]
fileContentToCards = map (\[x, y] -> (x, y)) . take nCards . chunksOf 2 . filter (not . null) . lines

userQuery :: (String, String) -> IO String
userQuery (question, answer) = do
  putStrLn $ question ++ " [Enter]"
  getLine
  putStrLn answer
  putStrLn "Correct?"
  getLine
userQuery _ = error "Malformed data"

main :: IO ()
main = do
  x <- readFile questionsFile >>= \cont ->
    mapM userQuery $ fileContentToCards cont
  print x
