-- the book calls this a "type synonym"
type Bits = [Bool]

xorBool :: Bool -> Bool -> Bool
xorBool value1 value2 = (value1 || value2) && (not (value1 && value2))

xorPair :: (Bool,Bool) -> Bool
xorPair (v1,v2) = xorBool v1 v2

xor :: [Bool] -> [Bool] -> [Bool]
xor list1 list2 = map xorPair (zip list1 list2)

intToBits' :: Int -> Bits
intToBits' 0 = [False]
intToBits' 1 = [True]
intToBits' n = if remainder == 0 -- if multiple of 2
               then False : intToBits' nextVal
               else True : intToBits' nextVal
  where remainder = n `mod` 2
        nextVal = n `div` 2

maxBits :: Int
maxBits = length (intToBits' maxBound)

intToBits :: Int -> Bits
intToBits n = leadingFalses ++ reversedBits
  where reversedBits  = reverse (intToBits' n)
        missingBits   = maxBits - (length reversedBits)
        leadingFalses = take missingBits (cycle [False])

charToBits :: Char -> Bits
charToBits char = intToBits (fromEnum char)


countTF :: (Num a, Num b) => [Bool] -> (a, b) -> (a, b)
countTF [] (a,b) = (a,b)
countTF (x:xs) (a,b) = countTF xs yy
  where yy = if x
             then (a+1,b)
             else (a,b+1)

countTF1 xs = [(if b then 1 else 0, if b then 1 else 0) | b <- xs]

bitsToInt :: Bits -> Int
bitsToInt bits = sum (map (\x -> 2^(snd x)) trueLocations)
  where size = length bits
        indices = [size-1,size-2 .. 0]
        trueLocations = filter (\x -> fst x == True)
                        (zip bits indices)

bitsToChar :: Bits -> Char
bitsToChar bits = toEnum (bitsToInt bits)

{-
    [True,True,False]

    (True:[True,False])
    (1,0)
    (True:[False])
    (2,0)

    
-}

