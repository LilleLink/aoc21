module Main where

main :: IO ()
main = do
    contents <- lines <$> readFile "example.txt"
    print contents