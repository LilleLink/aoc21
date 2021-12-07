module Main where
import Data.List.Split ( splitOn )

-- This needs to be compiled with -O flag to run efficiently!
-- See day7bv2.hs for smarter solution

main :: IO ()
main = do
    contents <- map (read :: String -> Int) . splitOn "," <$> readFile "input.txt"
    let result = minimum [fuel contents t | t <- [minimum contents .. maximum contents]]
    print result

fuel :: [Int] -> Int -> Int
fuel crabs target = sum $ map (\c -> sum $ take (abs (c-target)) [1..]) crabs

-- First version of getting the smallest delta, very rushed, replaced by list comprehension and fuel function
-- getCheapestDelta :: [Int] -> Int -> Int
-- getCheapestDelta ps maxdelta = findCheapest ps maxdelta (maximum ps)
--     where 
--         findCheapest :: [Int] -> Int -> Int -> Int
--         findCheapest ps 0  cmd = cmd
--         findCheapest ps cd cmd | totalCurrentDelta cd < totalCurrentDelta cmd = findCheapest ps (cd-1) cd
--                                | otherwise = findCheapest ps (cd-1) cmd
                               
--         totalCurrentDelta cd = sum $ map (\i -> sum $ take (abs (i-cd)) [1..]) ps
