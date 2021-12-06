module Main where

type Fish = Int

main :: IO ()
main = do
    fishes <- map (\s -> read s :: Fish) . segments (/=',') <$> readFile "input.txt"
    let after80days = iterate simulateDay fishes !! 80
    print $ length after80days

simulateDay :: [Fish] -> [Fish]
simulateDay fishes = incrementFishes fishes ++ newFishes
    where newFishes = replicate (countNewFishes fishes) 8

incrementFishes:: [Fish] -> [Fish]
incrementFishes = map incrementFish
    where
        incrementFish :: Fish -> Fish
        incrementFish fish | fish == 0 = 6
                           | otherwise = fish-1

countNewFishes :: [Fish] -> Int
countNewFishes fishes = length $ filter (==0) fishes

segments :: (a -> Bool) -> [a] -> [[a]]
segments _ [] = []
segments p xs = takeWhile p xs : segments p (drop 1 $ dropWhile p xs)