{-
-- EPITECH PROJECT, 2022
-- day 01 pool
-- File description:
-- First day of pool
-}

mySucc :: Int -> Int
mySucc n = n + 1

myIsNeg :: Int -> Bool
myIsNeg n
    | n < 0 = True
    | otherwise = False

myAbs :: Int -> Int
myAbs n
    | n < 0 = n * (-1)
    | otherwise = n

myMin :: Int -> Int -> Int
myMin a b
    | a < b = a
    | otherwise = b
    
myMax :: Int -> Int -> Int
myMax a b
    | a < b = b
    | otherwise = a
    
myTuple :: a -> b -> (a, b)
myTuple a b = (a, b)

myTruple :: a -> b -> c -> (a, b, c)
myTruple a b c = (a, b, c)

myFst :: (a, b) -> a
myFst (a, b) = a

mySnd :: (a, b) -> b
mySnd (a, b) = b

mySwap :: (a, b) -> (b, a)
mySwap (a, b) = (b, a)

myHead :: [a] -> a
myHead [] = error "84"
myHead (x: xs) = x

myTail :: [a] -> [a]
myTail [] = error "84"
myTail (x: xs)
    | otherwise = xs

myLength :: [a] -> Int
myLength [] = 0
myLength (x: xs) = 1 + myLength xs

myNth :: [a] -> Int -> a
myNth _ a
    | a < 0 = error "84"
myNth [x] a
    | a > 1  = error "84"
myNth (x: xs) 0 = x
myNth (x: xs) a = myNth xs (a - 1)

myTake :: Int -> [a] -> [a]
myTake _ [] = []
myTake a n
    | a > myLength n = n
myTake a (x: xs)
    | a < 1 = []
    | otherwise = (x:(myTake (a - 1) xs))
    
myDrop :: Int -> [a] -> [a]
myDrop 0 a = a
myDrop a n
    | a > myLength n = []
myDrop a (x:xs) = myDrop (a - 1) xs

myAppend ::[a]->[a]->[a]
myAppend [] x = x
myAppend (h:t) x = h:myAppend t x

myReverse2 :: [a] -> [a] -> [a]
myReverse2 [] b = b
myReverse2 a b = myReverse2 (myTail a) ((myHead a):b)

myReverse :: [a] -> [a]
myReverse [] = []
myReverse a = myReverse2 a []

myInit2 :: [a] -> [a]
myInit2 (x:xs) = myReverse xs

myInit :: [a] -> [a]
myInit [] = error "84"
myInit a = myInit2 (myReverse a)

myLast2 :: [a] -> a
myLast2 (x:xs) = x

myLast :: [a] -> a
myLast [] = error "84"
myLast a = myLast2 (myReverse a)

myZip :: [a] -> [b] -> [(a, b)]
myZip [] _ = []
myZip _ [] = []
myZip (x:xs) (x1:xs1) = (x, x1):(myZip xs xs1)

unzipLeft :: [(a,b)] -> [a]
unzipLeft [] = []
unzipLeft ((a, b):xs) = a:(unzipLeft xs)

unzipRight :: [(a,b)] -> [b]
unzipRight [] = []
unzipRight ((a, b):xs) = b:(unzipRight xs)

myUnzip :: [(a,b)] -> ([a], [b])
myUnzip t = (unzipLeft t, unzipRight t)

myMap :: (a -> b) -> [a] -> [b]
myMap f (x:[]) = f x : []
myMap f (x:xs) = f x : (myMap f xs)

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f (x:[])
    | f x==True = x:[]
    | otherwise = []
myFilter f (x:xs)
    | f x==True = x:myFilter f xs
    | otherwise = myFilter f xs
    
myFoldl :: (b -> a -> b) -> b -> [a] -> b
myFoldl f a (x:[]) = f a x
myFoldl f a (x:xs) = (myFoldl f (f a x) xs)

myFoldr :: (b -> a -> b) -> b -> [a] -> b
myFoldr f a b = myFoldl f a (myReverse b)

myPartition :: (a -> Bool) -> [a] -> ([a], [a])