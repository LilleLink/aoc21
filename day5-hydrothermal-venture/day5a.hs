module Main where
import Data.List.Split

main :: IO ()
main = do
    contents <- map (map (map (\s -> read s :: Int))) . map (map $ splitOn ",") . map (splitOn " -> ") . lines <$> readFile "input.txt"
    print contents

