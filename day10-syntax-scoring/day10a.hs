module Main where
import Data.List (sort, group)
import Data.Stack

main :: IO ()
main = do
    contents <- lines <$> readFile "input.txt"
    let new = map (getCorruptedCharacter stackNew) contents
    let scores = map charToScore new
    print $ sum scores

getCorruptedCharacter :: Stack Char -> String -> Char
getCorruptedCharacter stack []     = ' '
getCorruptedCharacter stack (c:cs) = if isOpeningCharacter c 
    then getCorruptedCharacter (stackPush stack c) cs 
    else (case stackPop stack of
        Just (s,sc) -> case c of
            ')' -> if sc == '(' then getCorruptedCharacter s cs else c
            ']' -> if sc == '[' then getCorruptedCharacter s cs else c
            '}' -> if sc == '{' then getCorruptedCharacter s cs else c
            '>' -> if sc == '<' then getCorruptedCharacter s cs else c
        Nothing -> c)

charToScore :: Char -> Int
charToScore c = case c of
    ')' -> 3
    ']' -> 57
    '}' -> 1197
    '>' -> 25137
    ' ' -> 0

isClosingCharacter :: Char -> Bool
isClosingCharacter s = ')' == s || '>' == s || ']' == s || '}' == s

isOpeningCharacter :: Char -> Bool
isOpeningCharacter s = '(' == s || '<' == s || '[' == s || '{' == s