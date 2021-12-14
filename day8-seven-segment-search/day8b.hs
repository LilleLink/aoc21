module Main where
import Data.List.Split (splitOn)
import Data.List ( (\\) )

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

-- Length 2 = 1
-- Length 3 = 7
-- Length 4 = 4
-- Length 5 = 2, 3, 5
-- Length 6 = 0, 6, 9
-- Length 7 = 8

-- For lengths of 6:
-- length 0 \ 1 = 4
-- length 6 \ 1 = 5
-- length 9 \ 1 = 4

-- length 0 \ 4 = 3
-- length 9 \ 4 = 2

-- For 2, 3, 5
-- length 2 \ 4 = 3
-- length 3 \ 4 = 2
-- length 5 \ 4 = 2

-- length 3 \ 1 = 3
-- length 5 \ 1 = 4

type Segment = (String, String)

main :: IO ()
main = do
    contents <- map (map words . splitOn " | ") . lines <$> readFile "input.txt"
    let outputs = [last x | x <- contents]
    let inputs  = [head x | x <- contents]
    let calculated =  map ((read :: String -> Int) . (\s -> calcOutputs (deduce $ head s) (last s))) contents
    print $ sum calculated

deduce :: [String] -> [Segment]
deduce strings = [(zero,"0"),(one,"1"), (two,"2"), (three,"3"), (four,"4"), (five,"5"), (six,"6"), (seven,"7"), (eight,"8"), (nine,"9")]
    where
        zero  = head (filter (\s -> length s == 6 && length (s \\ one) == 4 && length (s \\ four) == 3) strings)
        one   = head (filter (\s -> length s == 2) strings)
        two   = head (filter (\s -> length s == 5 && length (s \\ four) == 3) strings)
        three = head (filter (\s -> length s == 5 && length (s \\ four) == 2 && length (s \\ one) == 3) strings)
        four  = head (filter (\s -> length s == 4) strings)
        five  = head (filter (\s -> length s == 5 && length (s \\ four) == 2 && length (s \\ one) == 4) strings)
        six   = head (filter (\s -> length s == 6 && length (s \\ one) == 5) strings)
        seven = head (filter (\s -> length s == 3) strings)
        eight = head (filter (\s -> length s == 7) strings)
        nine  = head (filter (\s -> length s == 6 && length (s \\ one) == 4 && length (s \\ four) == 2) strings)

calcOutputs :: [Segment] -> [String] -> String
calcOutputs segments = concatMap getDigit
    where
        getDigit :: String -> String
        getDigit d = snd $ head $ filter (\(s,digit) -> all (`elem` s) d && length s == length d) segments

