module Main where
import Data.List.Split (splitOn)

type Point = (Int, Int)

main :: IO ()
main = do
    contents <- map (map (read :: String -> Int) . ((\(c:cs) -> cs) . splitOn "")) . lines <$> readFile "input.txt"
    let points = [(x,y) | x <- [0..length contents - 1], y <- [0..length (head contents) - 1]]  
    let appliedfunc = map (\(x,y) -> if isLowerThanAll (contents !! x !! y) (neighbors (x,y) contents) then contents !! x !! y else -1) points
    let lowpoints = filter (>=0) appliedfunc
    let score = sum $ map (+1) lowpoints
    print score

neighbors :: Point -> [[Int]] -> [Int]
neighbors (x,y) ps = map (\(x,y) -> ps !! x !! y) points
    where points =  filter (/= (x,y)) $ 
                    [(nx,ny) | nx <- [x-1,x,x+1], ny <- [y-1,y,y+1]
                    , ny >= 0 && nx >= 0 && ny < length (head ps) && nx < length ps] -- rectangular map

isLowerThanAll :: Int -> [Int] -> Bool
isLowerThanAll value = all (>value) 