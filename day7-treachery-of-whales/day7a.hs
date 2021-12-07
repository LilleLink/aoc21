module Main where
import Data.List.Split ( splitOn )
import Data.List (sort, group)

main :: IO ()
main = do
    contents <- map (\s -> read s :: Int) . splitOn "," <$> readFile "input.txt"
    let median = sort contents !! (length contents `div` 2)
    let delta  = map (\i -> abs (i-median)) contents
    print $ sum delta