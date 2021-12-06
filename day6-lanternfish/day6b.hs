module Main where
import Data.List.Split ( splitOn )

type Fish = Int

main :: IO ()
main = do
    content <- map (\s -> read s :: Fish) . splitOn "," <$> readFile "input.txt"
    let fishes = map (\s -> length $ filter (==s) content) [0..8]
    print $ sum $ iterate simulateDay fishes !! 256

simulateDay :: [Fish] -> [Fish]
simulateDay []            = []
simulateDay fishes@(f:fs) = take 6 fs ++ [fs !! 6 + f] ++ [fs !! 7] ++ [f] 
