
main :: IO ()
main = do
    contents <- map (\x -> read x :: Int) . lines <$> readFile "input.txt"
    let zipped = map fromEnum (zipWith (<) contents (drop 1 contents))
    print (sum zipped)

main2 :: IO ()
main2 = do
    contents <- map (\x -> read x :: Int) . lines <$> readFile "input.txt"
    let contents2 = drop 1 contents
    let windowed = toWindows contents
    let windowed2 = toWindows contents2
    let zipped = map fromEnum (zipWith (<) windowed windowed2)
    print (sum zipped)

toWindows :: [Int] -> [Int]
toWindows (x:y:z:[]) = [x+y+z]
toWindows (x:y:z:xs) = (x+y+z):[] ++ toWindows (y:z:xs)