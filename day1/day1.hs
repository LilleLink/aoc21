{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

main :: IO ()
main = do
    contents <- map (\x -> read x :: Int) . lines <$> readFile "input.txt"
    print $ sum $ map fromEnum (zipWith (<) contents (drop 1 contents))

main2 :: IO ()
main2 = do
    c1 <- toWindows . map (\x -> read x :: Int) . lines <$> readFile "input.txt"
    print $ sum $ map fromEnum (zipWith (<) c1 (drop 1 c1))

toWindows :: [Int] -> [Int]
toWindows []         = []
toWindows (x:y:z:[]) = [x+y+z]
toWindows (x:y:z:xs) = (x+y+z) : toWindows (y:z:xs)