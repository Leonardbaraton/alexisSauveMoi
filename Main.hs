{-
-- EPITECH PROJECT, 2022
-- day 01 pool
-- File description:
-- First day of pool
-}

import System.Environment (getArgs)

isNumber :: [Char] -> Bool
isNumber [] = True
isNumber (c:xs)
    | c >= '0' && c <= '9' = isNumber xs
    | otherwise = False

readInt :: [Char] -> Maybe Int
readInt [] = Nothing
readInt a
    | isNumber a = Just(read a)
    | otherwise = Nothing
                
myAdd :: Maybe Int -> Maybe Int -> IO Int
myAdd (Just a) (Just b) = do 
  let result = a + b
  print result
  return 0
myAdd _ _ = return 0

mySub :: Maybe Int -> Maybe Int -> IO Int
mySub (Just a) (Just b) = do 
  let result = a - b
  print result
  return 0
mySub _ _ = return 0

myTimes :: Maybe Int -> Maybe Int -> IO Int
myTimes (Just a) (Just b) = do 
  let result = a * b
  print result
  return 0
myTimes _ _ = return 0

myDiv :: Maybe Int -> Maybe Int -> IO Int
myDiv (Just a) (Just b) = do 
  let result = div a b
  print result
  return 0
myDiv _ _ = return 0

checkArgs :: String -> String -> String -> IO Int
checkArgs a b c = case (b) of
                      "+" -> myAdd (readInt a) (readInt c)
                      "-" -> mySub (readInt a) (readInt c)
                      "*" -> myTimes (readInt a) (readInt c)
                      "/" -> myDiv (readInt a) (readInt c)
                      _ -> return 0

main :: IO Int
main = do 
    args <- getArgs
    _ <- checkArgs (args!!0) (args!!1) (args!!2)
    return 0