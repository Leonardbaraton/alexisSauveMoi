{-
-- EPITECH PROJECT, 2025
-- Wolframe
-- File description:
-- Lib for main
-}

module Lib (stringToMaybeInt, parseArgs, generateNextRow, printRow) where

import Text.Read (readMaybe)
import Data.List (intercalate)

applyRule :: Int -> (Int, Int, Int) -> Int
applyRule 30 (l, c, r) = case (l, c, r) of
    (0, 0, 0) -> 0
    (0, 0, 1) -> 1
    (0, 1, 0) -> 1
    (0, 1, 1) -> 1
    (1, 0, 0) -> 1
    (1, 0, 1) -> 0
    (1, 1, 0) -> 0
    (1, 1, 1) -> 0
    _ -> error "Unexpected pattern in rule 30"
applyRule 90 (l, c, r) = case (l, c, r) of
    (0, 0, 0) -> 0
    (0, 0, 1) -> 1
    (0, 1, 0) -> 1
    (0, 1, 1) -> 0
    (1, 0, 0) -> 1
    (1, 0, 1) -> 0
    (1, 1, 0) -> 0
    (1, 1, 1) -> 1
    _ -> error "Unexpected pattern in rule 90"
applyRule 110 (l, c, r) = case (l, c, r) of
    (0, 0, 0) -> 0
    (0, 0, 1) -> 1
    (0, 1, 0) -> 1
    (0, 1, 1) -> 1
    (1, 0, 0) -> 1
    (1, 0, 1) -> 1
    (1, 1, 0) -> 1
    (1, 1, 1) -> 0
    _ -> error "Unexpected pattern in rule 110"
applyRule _ _ = error "Invalid rule"

stringToMaybeInt :: Maybe String -> Maybe Int
stringToMaybeInt (Just s) = readMaybe s
stringToMaybeInt Nothing  = Nothing

parseArgs :: [String] -> [(String, String)]
parseArgs (key:value:rest)
    | "--" `elem` [take 2 key] = (key, value) : parseArgs rest
parseArgs _ = []

generateNextRow :: Int -> [Int] -> [Int]
generateNextRow rule row =
  [applyRule rule (l, c, r) | (l, c, r) <- zip3 (0:row) row (drop 1 row ++ [0])]

printRow :: [Int] -> String
printRow = intercalate "" . map (\x -> if x == 1 then "*" else " ")
