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
    let initialRow = replicate (halfWindow config) 0 ++ [1] ++ replicate (halfWindow config) 0

    let rows = if (start config) == 0
            then initialRow
            else last $ take ((start config) + 1) $ iterate (generateNextRow ruleValue) initialRow

    if (line config) == -1
        then mapM_ (putStrLn . printRow) $ iterate (generateNextRow ruleValue) rows
        else mapM_ (putStrLn . printRow) $ take (line config) $ iterate (generateNextRow ruleValue) rows

fillConf :: Maybe Int -> Maybe Int -> Maybe Int -> Maybe Int -> Conf
fillConf startValue lineValue windowValue moveValue =
    Conf
    { start = case startValue of
        Just x -> x
        Nothing -> 0
    , line = case lineValue of
        Just x -> x
        Nothing -> -1
    , window = case windowValue of
        Just x -> x
        Nothing -> 80
    , move = case moveValue of
        Just x -> x
        Nothing -> 0
    }

main :: IO ()
main = do
    args <- getArgs
    let options = parseArgs args
    let ruleValue = stringToMaybeInt(lookup "--rule" options)
    let startValue = stringToMaybeInt(lookup "--start" options)
    let lineValue = stringToMaybeInt(lookup "--lines" options)
    let windowValue = stringToMaybeInt(lookup "--window" options)
    let moveValue = stringToMaybeInt(lookup "--move" options)

    let config = fillConf startValue lineValue windowValue moveValue

    case ruleValue of
        Just x -> mainRules config x
        Nothing -> exitWith (ExitFailure 84)
