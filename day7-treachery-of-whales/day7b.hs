module Main where
import Data.List.Split ( splitOn )
import Data.List (sort, group)

main :: IO ()
main = do
    contents <- map (\s -> read s :: Int) . splitOn "," <$> readFile "input.txt"
    let delta  = getCheapestDelta contents (maximum contents)
    let result = map (\i -> sum $ take (abs (i-delta)) [1..]) contents
    print $ sum result

getCheapestDelta :: [Int] -> Int -> Int
getCheapestDelta ps maxdelta = findCheapest ps maxdelta 1000
    where 
        findCheapest :: [Int] -> Int -> Int -> Int
        findCheapest ps 0  cmd = cmd
        findCheapest ps cd cmd | totalCurrentDelta cd < totalCurrentDelta cmd = findCheapest ps (cd-1) cd
                               | otherwise = findCheapest ps (cd-1) cmd

        totalCurrentDelta cd = sum $ map (\i -> sum $ take (abs (i-cd)) [1..]) ps


