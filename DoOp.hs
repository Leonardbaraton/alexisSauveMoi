{-
-- EPITECH PROJECT, 2022
-- day 01 pool
-- File description:
-- First day of pool
-}

myElem2 :: Eq a => a -> Int -> [a] -> Bool
myElem2 a i c
    | i >= length c = False
    | a == c!!i = True
    | otherwise = myElem2 a (i + 1) c

myElem :: Eq a => a -> [a] -> Bool
myElem a b
    | myElem2 a 0 b==True = True
    | otherwise = False

safeDiv :: Int -> Int -> Maybe Int
safeDiv _ 0 = Nothing
safeDiv a b = Just (div a b)

safeNth :: [a] -> Int -> Maybe a
safeNth a b
    | b < 0 = Nothing
    | b >= length a = Nothing
safeNth a b = Just (a!!b)

safeSucc :: Maybe Int -> Maybe Int
safeSucc Nothing = Nothing
safeSucc (Just a) = Just (a + 1)

myLookup :: Eq a => a -> [(a,b)] -> Maybe b
myLookup _ [] = Nothing
myLookup i ((a,b):xs)
    | i==a = Just b
    | otherwise = myLookup i xs
    
maybeDo :: (a -> b -> c) -> Maybe a -> Maybe b -> Maybe c
maybeDo _ Nothing _ = Nothing
maybeDo _ _ Nothing = Nothing
maybeDo f (Just a) (Just b) = Just (f a b)

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
    
getLineLength :: IO Int
getLineLength = do x <- getLine
                   return (length x)
                   
printAndGetLength :: String -> IO Int
printAndGetLength a = do _ <- putStr (a ++ "\n")
                         return (length a)

topAndBottom :: Int -> IO()
topAndBottom 0 = do 
                    _ <- putStr "+\n"
                    return ()
topAndBottom i = do 
                    _ <- putChar '-'
                    topAndBottom (i-1)

middle :: Int -> IO()
middle 0 = do
                _ <- putStr "|\n"
                return ()
middle i = do
                _ <- putChar ' '
                middle (i-1)
           
mainMiddle :: Int -> Int -> IO()
mainMiddle _ 0 = return () >> return ()
mainMiddle a i = do
                    _ <- putChar '|'
                    middle a
                    putChar '\n'
                    mainMiddle a (i-1)
               
printBox :: Int -> IO ()
printBox i
    | i < 1 = do return ()
printBox i = do
                _ <- putChar '+'
                topAndBottom ((i*2)-2)
                mainMiddle ((i*2)-2) (i - 2)
                putChar '+'
                topAndBottom ((i*2)-2)

concatLines :: Int -> IO String
concatLines i
    | i<=0 = do _ <- return ()
                return []
    | i==1 = do newStr <- getLine
                return(newStr)
concatLines i = do newStr <- getLine
                   finalStr <- (concatLines (i - 1))
                   return(newStr ++ finalStr)
                   
getInt :: IO (Maybe Int)
getInt = do charInt <- getLine
            if (isNumber charInt) == True
                then return (Just (read charInt))
                else return Nothing