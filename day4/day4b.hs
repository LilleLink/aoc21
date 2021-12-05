module Main where
import Data.List (transpose)

main :: IO ()
main = do
    instructions <- map (\s -> read s :: Int) . segments (/=',') <$> readFile "instructions.txt"
    boards       <- map (map (map (\s -> read s :: Int) . words)) . segments (/="") . lines <$> readFile "boards.txt"
    let draws     = zip (map (\b -> nrOfDrawsToWin b (transpose b) instructions) boards) boards
    let minDraws  = getMaxDraws (map fst draws)
    let draws     = fst minDraws
    let minboard  = take 5 $ map snd (snd minDraws)
    let unmarked  = filter (\s -> s `notElem` take draws instructions) (concat minboard)
    print $ sum unmarked * last (take draws instructions)

segments :: (a -> Bool) -> [a] -> [[a]]
segments _ [] = []
segments p xs = takeWhile p xs : segments p (drop 1 $ dropWhile p xs)

nrOfDrawsToWin :: Eq a => [[a]] -> [[a]] -> [a] -> (Int,[(Int, [a])])
nrOfDrawsToWin rs cs is = (minimum $ map fst calcedBoard, calcedBoard)
    where
        rowsToScore rs is = map (checkRow is 0) rs
        checkRow is p r
            | all (`elem` take p is) r = (p, r)
            | otherwise = checkRow is (p + 1) r
        calcedBoard = rowsToScore rs is ++ rowsToScore cs is

getMaxDraws :: [(Int, [a])] -> (Int, [a])
getMaxDraws bs = maxboard bs (head bs)
    where
        maxboard [] currentMax         = currentMax
        maxboard ((i,b):bs) currentMax | fst currentMax < i = maxboard bs (i,b)
                                       | otherwise          = maxboard bs currentMax

