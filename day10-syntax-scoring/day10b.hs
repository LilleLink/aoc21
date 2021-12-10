module Main where
import Data.List (sort, group)
import Data.Stack ( Stack, stackNew, stackPop, stackPush, stackIsEmpty )
import Data.Maybe (fromJust)

main :: IO ()
main = do
    contents <- lines <$> readFile "input.txt"
    let nocorrupted = filter (not . isCorrupted stackNew) contents
    let stacks = map (getCorruptedStack stackNew) nocorrupted
    let strings = map (map counterpart . stackToList) stacks
    let scores = sort $ map stringToScore strings
    print (scores !! round (fromIntegral (length scores) / 2))

stackToList :: Stack a -> [a]
stackToList stack | stackIsEmpty stack = []
                  | otherwise          = case stackPop stack of
                      Just (s, sc) -> sc : stackToList s
                      Nothing      -> []

isCorrupted :: Stack Char -> String -> Bool
isCorrupted stack []     = False
isCorrupted stack (c:cs) = if isOpeningCharacter c
    then isCorrupted (stackPush stack c) cs
    else (case stackPop stack of
        Just (s,sc) -> case c of
            ')' -> sc /= '(' || isCorrupted s cs
            ']' -> sc /= '[' || isCorrupted s cs
            '}' -> sc /= '{' || isCorrupted s cs
            '>' -> sc /= '<' || isCorrupted s cs
        Nothing -> True)

getCorruptedStack :: Stack Char -> String -> Stack Char
getCorruptedStack stack []     = stack
getCorruptedStack stack (c:cs) = if isOpeningCharacter c
    then getCorruptedStack (stackPush stack c) cs
    else (case stackPop stack of
        Just (s,sc) -> case c of
            ')' -> if sc == '(' then getCorruptedStack s cs else s
            ']' -> if sc == '[' then getCorruptedStack s cs else s
            '}' -> if sc == '{' then getCorruptedStack s cs else s
            '>' -> if sc == '<' then getCorruptedStack s cs else s
        Nothing -> stack)

counterpart :: Char -> Char
counterpart c = case c of
    '(' -> ')'
    '[' -> ']'
    '{' -> '}'
    '<' -> '>'

charToScore :: Char -> Int
charToScore c = case c of
    ')' -> 1
    ']' -> 2
    '}' -> 3
    '>' -> 4

stringToScore :: String -> Int
stringToScore str = cts str 0
    where
        cts []     total = total
        cts (c:cs) total = cts cs ((total*5) + charToScore c) 

isClosingCharacter :: Char -> Bool
isClosingCharacter s = ')' == s || '>' == s || ']' == s || '}' == s

isOpeningCharacter :: Char -> Bool
isOpeningCharacter s = '(' == s || '<' == s || '[' == s || '{' == s