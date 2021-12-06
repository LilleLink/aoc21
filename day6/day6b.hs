module Main where

type Fish = Int

main :: IO ()
main = do
    content <- map (\s -> read s :: Fish) . segments (/=',') <$> readFile "input.txt"
    putStr "Enter number of simulation days > "
    n <- (\s -> read s :: Int) <$> getLine
    let fishes = map (\s -> length $ filter (==s) content) [0..8]
    print $ sum $ iterate simulateDay fishes !! n

simulateDay :: [Fish] -> [Fish]
simulateDay []            = []
simulateDay fishes@(f:fs) = take 5 fs ++ [fs !! 5] ++ [fs !! 6 + f] ++ [fs !! 7] ++ [f] 

segments :: (a -> Bool) -> [a] -> [[a]]
segments _ [] = []
segments p xs = takeWhile p xs : segments p (drop 1 $ dropWhile p xs)