module Main where
import Data.List.Split ( splitOn )
import Data.List (nub, sortBy, sort)
import Data.Function (on)

type Point = (Int,Int)
type Basin = [Point]

main :: IO ()
main = do
    contents <- map (map (read :: String -> Int) .
                ((\(c:cs) -> cs) . splitOn ""))  .
                lines <$> readFile "input.txt"
    let points = [(x,y) | x <- [0..length contents - 1],
                          y <- [0..length (head contents) - 1]]
    let lowpoints = filter (isLowpoint contents) points
    let basins = map (getBasin contents) lowpoints
    print $ product . take 3 . reverse . sort $ map length basins

getBasin :: [[Int]] -> Point -> Basin
getBasin pmap point = basin [point] []
    where
        basin :: [Point] -> [Point] -> [Point]
        basin []     visited = visited
        basin (p:ps) visited = basin (ps ++ [nb | nb <- immediateNeighbors pmap p, nb `notElem` (visited++ps), valueOf pmap nb /= 9]) (p:visited)  
            

isLowpoint :: [[Int]] -> Point -> Bool
isLowpoint pmap (x,y) = all (>pmap !! x !! y) (neighbors pmap (x,y))

pointsToValue :: [[Int]] -> [Point] -> [Int]
pointsToValue pmap points = [pmap !! x !! y | (x,y) <- points]

valueOf :: [[Int]] -> Point -> Int
valueOf pmap (x,y) = pmap !! x !! y

immediateNeighbors :: [[Int]] -> Point -> [Point]
immediateNeighbors pmap (px,py) = immediate
    where
        immediate = [(x,py) | x <- [px-1,px+1], x >= 0, x < length pmap] ++
                    [(px,y) | y <- [py-1,py+1], y >= 0, y < length (head pmap)]

neighbors :: [[Int]] -> Point -> [Int]
neighbors ps (x,y) = map (\(x,y) -> ps !! x !! y) points
    where points =  filter (/= (x,y)) $
                    [(nx,ny) | nx <- [x-1,x,x+1], ny <- [y-1,y,y+1]
                    , ny >= 0 && nx >= 0 && ny < length (head ps) && nx < length ps]