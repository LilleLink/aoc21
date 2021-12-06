module Main where

main :: IO ()
main = do
    contents <- lines <$> readFile "input.txt"
    let new = map (segments (/='>')) contents
    print new

segments :: (a -> Bool) -> [a] -> [[a]]
segments _ [] = []
segments p xs = takeWhile p xs : segments p (drop 1 $ dropWhile p xs)