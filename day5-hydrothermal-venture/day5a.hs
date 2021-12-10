module Main where
import Data.List.Split
import Data.List (sort, group)

type Point = (Int,Int)
data VentLine = VentLine Point Point -- from and to
    deriving Show

main :: IO ()
main = do
    contents <- map entryToLine
                . map (map (map (\s -> read s :: Int)))
                . map (map $ splitOn ",")
                . map (splitOn " -> ") . lines
                <$> readFile "input.txt"
    let ventmap = [replicate 10 0 | x <- [1..1000]]
    let mapped = length $ filter (\l -> length l > 1) $ group $ sort $ concatMap points contents
    print mapped

isDiagonal :: VentLine -> Bool
isDiagonal (VentLine p1 p2) | fst p1 == fst p2 || snd p1 == snd p2 = False
                            | otherwise = True

points :: VentLine -> [Point]
points (VentLine from to) 
        | x0 == x1 = [(x0,i) | i <- ys]
        | y0 == y1 = [(i,y0) | i <- xs]
        | otherwise = [] -- its diagonal
    where 
        x0 = fst from
        x1 = fst to
        y0 = snd from
        y1 = snd to
        xs 
            | x0 > x1 = [x1..x0]
            | otherwise = [x0..x1]
        ys 
            | y0 > y1 = [y1..y0]
            | otherwise = [y0..y1]

entryToLine :: [[Int]] -> VentLine
entryToLine e = VentLine (head (head e),last (head e))
                         (head (last e),last (last e))