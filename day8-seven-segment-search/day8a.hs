module Main where
import Data.List.Split (splitOn)

-- 0 = 6
-- 1 = 2 - unique
-- 2 = 5
-- 3 = 5
-- 4 = 4 - unique
-- 5 = 5
-- 6 = 6
-- 7 = 3 - unique
-- 8 = 7 - unique
-- 9 = 6

-- The rest of the numbers contain 5/6 segments respectively

-- Segments: 
-- top          - the char that doesnt exist in 1 but exists in 7
-- right side   - chars that exist in the union of 7 and 1
-- middle and top left - chars that exist in 4 but not in 7 except the top segment

-- this is all we can deduce from the digits with unique segment lengths
-- all of these in union form the 9

-- Example
-- be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb
--  dddd
-- c    e
-- c    e
-- c    e
--  gggg
--      b
--      b
--      b
-- 

-- be       = 1
-- cgeb     = 4
-- edb      = 7
-- cfbegad  = 8


main :: IO ()
main = do
    contents <- map (map words . splitOn " | ") . lines <$> readFile "input.txt"
    let outputs = [last x | x <- contents]
    let uniquelengths = [2,3,4,7]
    let lengths = length $ concatMap (filter (`elem` uniquelengths) . map length) outputs
    print lengths