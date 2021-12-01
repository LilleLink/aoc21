{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

main :: IO ()
main = do
    contents <- map (\x -> read x :: Int) . lines <$> readFile "input.txt"
    let zipped = map fromEnum (zipWith (<) contents (drop 1 contents))
    print (sum zipped)

main2 :: IO ()
main2 = do
    c1 <- toWindows . map (\x -> read x :: Int) . lines <$> readFile "input.txt"
    let zipped = map fromEnum (zipWith (<) c1 (drop 1 c1))
    print (sum zipped)

toWindows :: [Int] -> [Int]
toWindows []         = []
toWindows (x:y:z:[]) = [x+y+z]
toWindows (x:y:z:xs) = (x+y+z) : toWindows (y:z:xs)