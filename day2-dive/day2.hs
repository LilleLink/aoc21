{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

main :: IO ()
main = do
    res <- foldl calculate (0,0,0) <$> (map words . lines <$> readFile "input.txt")
    print $ finalPosition res

calculate :: (Int, Int, Int) -> [String] -> (Int, Int, Int)
calculate (h,d,a) s = case head s of
    "forward" -> (h + value, d + (a * value), a)
    "up"      -> (h, d, a - value)
    "down"    -> (h, d, a + value)
    where value = read $ last s :: Int

finalPosition :: Num a => (a, a, a) -> a
finalPosition (h,d,a) = h*d