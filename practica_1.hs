-- Ejercicio 1 --
-- La función subtract ya esta definida en Prelude
max2 :: Float -> Float -> Float
max2 x y | x >= y = x
         | otherwise = y

normaVectorial :: Float -> Float -> Float
normaVectorial x y = sqrt (x^2 + y^2)


predecesor :: Float -> Float
predecesor = subtract 1

evaluarEnCero :: (Float -> b) -> b
evaluarEnCero = \f -> f 0

dosVeces :: (a -> a) -> (a -> a)
dosVeces = \f -> f.f

flipAll :: [a -> b -> c] -> [ b -> a -> c]
flipAll = map flip

flipRaro :: b -> ( a -> b -> c ) -> a -> c
flipRaro = flip flip

-- Ejercicio 2 --
ejercicio2 :: [Integer]
ejercicio2 = [ x | x <- [1..3], y <- [x..3], ( x + y ) `mod` 3 == 0 ]

-- Ejercicio 3 --
pitagoricas :: [(Integer, Integer, Integer)]
pitagoricas =  [ (a, b, c) | c <- [1..], b <-[1..c], a <- [1..c], a^2 + b^2 == c^2]