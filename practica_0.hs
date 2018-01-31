module Practica0 where
-- Auxiliares --
esPrimo:: Int -> Bool
esPrimo x = length (divisores x) == 2 

divisores:: Int -> [Int]
divisores x = [ y | y <- [1..x], x `mod` y == 0 ]   

-- Ejercicio 2 --
valorAbsoluto :: Float -> Float
valorAbsoluto x | x < 0     = -x
                | otherwise =  x

bisiesto :: Int -> Bool
bisiesto x = (x `mod` 4) == 0

factorial :: Int -> Int
factorial 1 = 1
factorial x = x * factorial (x-1)

cantDivisoresPrimos :: Int -> Int
cantDivisoresPrimos x = length (filter esPrimo (divisores x));

-- Ejercicio 3 --
inverso :: Float -> Maybe Float
inverso 0 = Nothing
inverso x = Just (1/x)

aEntero :: Either Int Bool -> Int
aEntero (Left x) = x
aEntero (Right x) | x == True = 1
                  | otherwise = 0

-- Ejercicio 4 --
limpiar :: String -> String -> String
limpiar xs ys = [ y | y <- ys, not(elem y xs) ]