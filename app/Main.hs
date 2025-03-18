-- EPITECH PROJECT, 2025
-- Alexis Leonard
-- File description:
-- Image compressor using k-means algorithm

import System.Environment (getArgs)
import System.IO (readFile)
import Text.Read (readMaybe)
import System.Random (randomRIO)

type Pixel = ((Int, Int), (Int, Int, Int))

parsePixel :: String -> Maybe Pixel
parsePixel line = case words line of
    [pos, col] -> do
        (x, y) <- parsePoint pos
        (r, g, b) <- parseColor col
        return ((x, y), (r, g, b))
    _ -> Nothing
  where
    parsePoint :: String -> Maybe (Int, Int)
    parsePoint s = case reads s of
        [(coords, "")] -> Just coords
        _ -> Nothing
    parseColor :: String -> Maybe (Int, Int, Int)
    parseColor s = case reads s of
        [(color, "")] -> Just color
        _ -> Nothing

parseFile :: String -> IO [Pixel]
parseFile filename = do
    content <- readFile filename
    let linesContent = lines content
        parsedPixels = mapM parsePixel linesContent
    case parsedPixels of
        Just pixels -> return pixels
        Nothing -> fail "Error in file parsing"

selectRandomCentroid :: [Pixel] -> IO Pixel
selectRandomCentroid pixels = do
    index <- randomRIO (0, length pixels - 1)
    return (pixels !! index)

initializeCentroids :: Int -> [Pixel] -> IO [(Int, Int, Int)]
initializeCentroids n pixels = do
    centroids <- mapM (\_ -> selectRandomCentroid pixels) [1..n]
    return $ map snd centroids

distance :: (Int, Int, Int) -> (Int, Int, Int) -> Double
distance (r1, g1, b1) (r2, g2, b2) = sqrt $ fromIntegral ((r1 - r2)^2 + (g1 - g2)^2 + (b1 - b2)^2)

assignToCentroids :: [Pixel] -> [(Int, Int, Int)] -> [[Pixel]]
assignToCentroids pixels centroids = map (\c -> filter (isClosestTo c) pixels) centroids
  where
    isClosestTo :: (Int, Int, Int) -> Pixel -> Bool
    isClosestTo c (_, (r, g, b)) = all (\c' -> distance (r, g, b) c' >= distance (r, g, b) c) centroids

updateCentroids :: [[Pixel]] -> [(Int, Int, Int)]
updateCentroids clusters = map averageColor clusters
  where
    averageColor :: [Pixel] -> (Int, Int, Int)
    averageColor cluster = let
      (sumR, sumG, sumB) = foldr (\(_, (r, g, b)) (sr, sg, sb) -> (sr + r, sg + g, sb + b)) (0, 0, 0) cluster
      in (sumR `div` length cluster, sumG `div` length cluster, sumB `div` length cluster)

hasConverged :: [(Int, Int, Int)] -> [(Int, Int, Int)] -> Double -> Bool
hasConverged oldCentroids newCentroids limit = all (\(old, new) -> distance old new <= limit) (zip oldCentroids newCentroids)

main :: IO ()
main = do
    args <- getArgs
    case args of
        ["-n", nStr, "-l", lStr, "-f", filename] ->
            let parsedArgs = (readMaybe nStr :: Maybe Int, readMaybe lStr :: Maybe Double)
            in case parsedArgs of
                (Just n, Just l) -> do
                    pixels <- parseFile filename
                    centroids <- initializeCentroids n pixels
                    let maxIterations = 100
                    finalCentroids <- kMeans maxIterations l pixels centroids []
                    printClusters finalCentroids pixels
                _ -> putStrLn "Erreur: N doit être un entier et L un flottant."
        _ -> putStrLn "USAGE: ./imageCompressor -n N -l L -f F\n" >>
             putStrLn "    N    number of colors in the final image" >>
             putStrLn "    L    convergence limit" >>
             putStrLn "    F    path to the file containing the colors of the pixels"

printClusters :: [(Int, Int, Int)] -> [Pixel] -> IO ()
printClusters centroids pixels = do
    let clusters = assignToCentroids pixels centroids
    mapM_ printCluster (zip centroids clusters)

printCluster :: ((Int, Int, Int), [Pixel]) -> IO ()
printCluster (color, points) = do
    putStrLn " - -"
    putStrLn $ show color
    putStrLn " -"
    mapM_ printPoint points

printPoint :: Pixel -> IO ()
printPoint ((x, y), color) = do
    putStrLn $ "(" ++ show x ++ "," ++ show y ++ ") " ++ show color

kMeans :: Int -> Double -> [Pixel] -> [(Int, Int, Int)] -> [[Pixel]] -> IO [(Int, Int, Int)]
kMeans maxIterations limit pixels centroids clusters = do
    let clusters' = assignToCentroids pixels centroids
    let newCentroids = updateCentroids clusters'
    if hasConverged centroids newCentroids limit
        then return newCentroids
        else if maxIterations > 0
            then kMeans (maxIterations - 1) limit pixels newCentroids clusters'
            else return newCentroids
