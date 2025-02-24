module Main (main) where

import System.Environment (getArgs)
import System.Exit (exitWith, ExitCode(..))


import Lib (stringToMaybeInt, parseArgs, generateNextRow, printRow)

data Conf = Conf
  { start :: Int
  , line :: Int
  , window :: Int
  , move :: Int
  } deriving (Show)

halfWindow :: Conf -> Int
halfWindow conf = ((window conf) + (move conf)) `div` 2

mainRules :: Conf -> Int -> IO ()
mainRules config ruleValue = do
    let w = halfWindow config
        initialRow = replicate w 0 ++ [1] ++ replicate w 0
        rows = getStartingRow config ruleValue initialRow
        generatedRows = iterate (generateNextRow ruleValue) rows
        output = takeRows config generatedRows
    mapM_ (putStrLn . printRow) output

getStartingRow :: Conf -> Int -> [Int] -> [Int]
getStartingRow config ruleValue row
    | start config == 0 = row
    | otherwise = last $ take (start config + 1) $ iterate (generateNextRow ruleValue) row

takeRows :: Conf -> [[Int]] -> [[Int]]
takeRows config rows
    | line config == -1 = rows
    | otherwise = take (line config) rows

fillConf :: Maybe Int -> Maybe Int -> Maybe Int -> Maybe Int -> Conf
fillConf startValue lineValue windowValue moveValue = Conf
    { start  = fromMaybeInt startValue 0
    , line   = fromMaybeInt lineValue (-1)
    , window = fromMaybeInt windowValue 80
    , move   = fromMaybeInt moveValue 0
    }

fromMaybeInt :: Maybe Int -> Int -> Int
fromMaybeInt (Just x) _ = x
fromMaybeInt Nothing  d = d


getConfig :: [(String, String)] -> Conf
getConfig options =
    let startValue = stringToMaybeInt (lookup "--start" options)
        lineValue = stringToMaybeInt (lookup "--lines" options)
        windowValue = stringToMaybeInt (lookup "--window" options)
        moveValue = stringToMaybeInt (lookup "--move" options)
    in fillConf startValue lineValue windowValue moveValue

main :: IO ()
main = do
    args <- getArgs
    let options = parseArgs args
        ruleValue = stringToMaybeInt (lookup "--rule" options)
        config = getConfig options
    case ruleValue of
        Just x -> mainRules config x
        Nothing -> exitWith (ExitFailure 84)
