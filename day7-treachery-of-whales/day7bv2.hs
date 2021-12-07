module Main where
import Data.List.Split ( splitOn )

-- No credit to me for this solution

main :: IO ()
main = do
    contents <- map (read :: String -> Int) . splitOn "," <$> readFile "input.txt"
    let target = round (fromIntegral (sum contents) / fromIntegral (length contents))
    print $ fuel contents target

fuel :: [Int] -> Int -> Int
fuel crabs target = sum $ map (\c -> sum $ take (abs (c-target)) [1..]) crabs
