module Main where
import Data.List (transpose)

main :: IO ()
main = do
    instructions <- map (\s -> read s :: Int) . segments (/=',') <$> readFile "instructions.txt"
    boards       <- map (map (map (\s -> read s :: Int) . words)) . segments (/="") . lines <$> readFile "boards.txt"
    let draws = map (\b -> nrOfDrawsToWin b (transpose b) instructions) boards
    print draws

segments :: (a -> Bool) -> [a] -> [[a]]
segments _ [] = []
segments p xs = takeWhile p xs : segments p (drop 1 $ dropWhile p xs)

nrOfDrawsToWin :: [[a]] -> [[a]] -> [a] -> Int
nrOfDrawsToWin rs cs is = minimum [checkRows rs is 0, checkRows cs is 0]
    where
        checkRows :: [[a]] -> [a] -> Int -> Int
        checkRows (r:rs) is p = undefined