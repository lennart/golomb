module Data.Golomb
  ( golomb
  , distances
  , disjunct
  , relativize
  ) where

import Data.List

golomb :: Int -> [Int]
golomb l = l : golomb' l

golomb' :: Int -> [Int]
golomb' 0 = []
golomb' l = q : golomb' q
  where
    q = golombhalver l

golombhalver :: Int -> Int
golombhalver l
  | res > 0 = res
  | otherwise = 0
  where
    res = (l `div` 2) - 1

relativize
  :: Fractional c
  => Int -> [c]
relativize n = snd $ mapAccumL relativizer (golomb n) (golomb n)
  where
    relativizer acc el = (acc, fromIntegral el / fromIntegral (head acc))

distances :: [(Integer, Integer)] -> [Integer]
distances = map dist
  where
    dist (a, b) = b - a

disjunct
  :: Ord a
  => [a] -> [(a, a)]
disjunct ls = foldl union [] $ snd $ mapAccumL disjunctAccum ls ls

disjunctAccum
  :: Ord a
  => [a] -> a -> ([a], [(a, a)])
disjunctAccum acc el = (acc, zipWith f rest (replicate (length rest) el))
  where
    f a b
      | a > b = (b, a)
      | b > a = (a, b)
      | otherwise = (a, b)
    rest = filter (/= el) acc
