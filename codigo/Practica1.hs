module Practica1 where

import Practica0

-- Ejercicio 1 --
-- La función subtract ya esta definida en Prelude
max2 ::(Float, Float) -> Float
max2 (x, y) | x >= y = x        
            | otherwise = y

max2Currificada :: Float -> Float -> Float
max2Currificada x y | x >= y = x
                    | otherwise = y

normaVectorial :: (Float, Float) -> Float
normaVectorial (x, y) = sqrt (x^2 + y^2)

normaVectorialCurrificada :: Float -> Float -> Float
normaVectorialCurrificada x y = sqrt (x^2 + y^2)

-- subtract ys esta definida en Prelude
subtract1 :: Float -> Float -> Float  
subtract1 = flip (-)

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





-- Ejercicio 4 --
primerosPrimos :: Int -> [Int]
primerosPrimos n = take n [ x | x <- [2..], esPrimo x ]





-- Ejercicio 5 --
partir :: [ a ] -> [ ( [ a ], [ a ] ) ]
partir xs = [ ( take i xs, drop i xs ) | i <- [ 0.. ( length xs ) ] ]





-- Ejercicio 6 -- Repite listas
listasQueSuman :: Int -> [[Int]]
listasQueSuman 1 = [[1]]
listasQueSuman n = [n]: ( concat
    [ map ( (n-i): ) ( listasQueSuman i ) | i <- [ 1..n-1 ] ] ) 

induccionGlobal:: (Int -> Int -> b -> b) -> (Int -> [b] -> b) -> b -> Int -> b
induccionGlobal _ _ z 1 = z
induccionGlobal g f z n = f n [ g n i ( induccionGlobal g f z i ) | i <- [ 1..(n-1) ] ]

listasQueSumanIG :: Int -> [[Int]]
listasQueSumanIG = induccionGlobal
    (\i j -> map ((i-j):) )
    (\x xs -> [x]:(concat xs)) 
    [[1]]





--  Ejercicio 7 --
listasFinitas :: [[Int]]
listasFinitas = concat [ listasQueSuman i | i <- [1..] ]





-- Ejercicio 8 --
curry1 :: ((a,b) -> c) -> a -> b -> c
curry1 f a b = f (a,b)

uncurry1 :: (a -> b -> c) -> (a, b) -> c
uncurry1 f (a, b) = f a b





-- Ejercicio 9 --
-- I
type DivideConquer a b = (a -> Bool)    -- determina si es o no el caso trivial
                         -> (a -> b)    -- resuelve el caso trivial
                         -> (a -> [a])  -- parte el problema en sub-problemas
                         -> ([b] -> b)  -- combina resultados
                         -> a           -- estructura de entrada
                         -> b           -- resultado--

dc :: DivideConquer a b
dc esTrivial resolver repartir combinar x = 
    if esTrivial x then 
        resolver x 
    else combinar (map  (dc esTrivial resolver repartir combinar) (repartir x))

-- II 
mergesort :: Ord a => [a] -> [a]
mergesort = dc ((<=1).length)
    id
    partirALaMitad
    (\[xs,ys] -> merge xs ys)

-- III
mapDC :: (a -> b) -> [a] -> [b]
mapDC f = dc ((<=1).length)
    ( \xs -> if (length xs) == 0 then [] else [ f (head xs) ] )
    partirALaMitad
    concat

filterDC :: (a -> Bool) -> [a] -> [a]
filterDC p = dc ((<=1).length)
    (\xs -> if (length xs == 0) || (p (head xs)) then [] else xs )
    partirALaMitad
    concat
-- Auxiliares

partirALaMitad :: [a] -> [[a]]
partirALaMitad xs = [ take i xs, drop i xs ] 
    where i = (div (length xs) 2)

merge :: Ord a => [a] -> [a] -> [a]
merge = foldr (\y rec -> (filter (<= y) rec) ++ [y] ++ (filter (>y) rec))

-- mapper :: (a->b) -> [a] -> [b]
-- mapper f = divideCoquer 
--     ((<=1).length) 
--     (\xs -> if (length xs) == 0 then [] else [ f (head xs )] ) 
--     (\xs -> [take ((length xs)`div`2) xs, drop ((length xs)`div`2) xs]) 
--     (\[xs,ys] -> xs++ys) 

-- ffilter :: (a->Bool) -> [a] -> [a]
-- ffilter p = divideCoquer
--     ((<=1).length)
--     (\xs -> if (length xs) == 0 then [] else (if (p (head xs)) then xs else []) )
--     (\xs -> [take ((length xs)`div`2) xs, drop ((length xs)`div`2) xs]) 
--     (\[xs,ys] -> xs++ys) 





-- Ejercicio 10 --
-- I
sumFold :: Num a => [a] -> a
sumFold = foldr (+) 0

elemFold :: Eq a => a -> [a] -> Bool
elemFold x = foldr (\y rec -> (y==x) || rec) False

masMasFold :: [a] -> [a] -> [a]
masMasFold = flip (foldr (\x rec-> x:rec) )
-- -- masmas xs ys = foldr (\x rec-> x:rec) ys xs)

mapFold :: (a->b) -> [a] -> [b]
mapFold f = foldr (\x rec-> (f x):rec) []

filterFold :: (a->Bool) -> [a] -> [a]
filterFold p = foldr (\x rec -> if (p x) then x:rec else rec) []

-- II
mejorSegun :: (a -> a -> Bool) -> [a] -> a
mejorSegun f = foldr1 (\x rec -> if f x rec then x else rec)

-- --mejorSegun f [x] = x
-- --mejorSegun f (x:xs) | f x (mejorSegun f xs) = x
-- --                    | otherwise = mejorSegun f xs

-- III
sumaAlt :: Num a => [a] -> a   -- Preguntar
sumaAlt xs = fst 
        (foldr (\x (rec,b) -> if b then (x + rec , False) else  (x - rec, True) ) 
        (0,signo) 
        xs)
    where signo = not (((length xs) `mod` 2) == 0)
-- -- si es par da false => [1,2,3,4] 0 (1+(2-(3+(4-0))))

-- IV
sumaAlt2 :: Num a => [a] -> a
sumaAlt2 xs = fst 
        (foldr (\x (rec,b) -> if b then (x + rec , False) else (x - rec, True) ) 
        (0,signo) 
        xs)
    where signo = (((length xs) `mod` 2) == 0)

--recTuplas :: (a -> (b,c) -> (b,c)) -> (b,c) -> [a] -> b
--recTuplas f t xs = fst( 
--        foldr (\x rect -> f x rect) 
--        t
--        xs)

-- V
permutaciones :: [a] -> [[a]]
permutaciones = foldr (\x rec-> concatMap (agregarEnTodasLasPosiciones x) rec) [[]] 
    where agregarEnTodasLasPosiciones j js = [ (fst h)++[j]++(snd h)| h <- (partir js)]





-- Ejercicio 11 --
partes :: [a] -> [[a]]
partes = foldr (\x res -> res ++ (map (x:) res)) [[]]

prefijos :: [a] -> [[a]]
prefijos xs = [take i xs | i <- [0..(length xs)]]

sublistas :: [a] -> [[a]]
sublistas xs = [[]] ++ [ take j (drop i xs)  | i<-[0..(length xs)] , j<-[1..(length xs)-i]]
--sublistas xs = [ drop i (take j xs)  | i<-[0..(length xs)] , j<-[i..(length xs)]]





-- Ejercicio 12 --
recr::(a->[a]->b->b)->b->[a]->b
recr _ z [] = z
recr f z (x:xs) = f x xs (recr f z xs)

sacarUna :: Eq a => a -> [a] -> [a]
sacarUna x = recr (\y ys rec -> if (x==y) then ys else y:rec) []





-- Ejercicio 13 --
genLista :: a -> (a -> a) -> Int -> [a]
genLista x f 0 = [x]
genLista x f n = x:(genLista (f x) f (n-1))

desdeHasta :: Int -> Int -> [Int]
desdeHasta x z = genLista x (+1) (z-x)






-- Ejercicio 14 --
mapPares :: (a -> b -> c) -> [(a,b)] -> [c]
mapPares f = map (uncurry f)

--armarPares :: [a] -> [b] -> [(a,b)]
--armarPares ys = foldr (\x rec -> foldr (\y _ -> (x,y):rec) []) (\l -> [])

mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble f as bs  = mapPares f (zip as bs)





-- Ejercicio 15 --
sumaMat :: [[Int]] -> [[Int]] -> [[Int]]
sumaMat = zipWith (id)--(\(fila1,fila2) -> (zipWith (\(x,y) -> x+y) fila1 fila2) )

-- Ejercicio 16 --
-- stop next
generate :: ([a] -> Bool) -> ([a] -> a) -> [a]
generate stop next = generateFrom stop next []

generateFrom:: ([a] -> Bool) -> ([a] -> a) -> [a] -> [a]
generateFrom stop next xs | stop xs = init xs
    | otherwise = (generateFrom stop next (xs ++ [next xs]))

generateBase::([a] ->Bool) ->a ->(a ->a) ->[a]
generateBase stop x next = generate stop (\xs -> if ((length xs) == 0) then x else (next (last xs)) ) 
--    stop elem inicial next

factoriales::Int ->[Int]
factoriales n = generate 
    (\xs -> (length xs) == n+1) 
    (\xs -> if ((length xs) == 0) then 1 else (last xs)*(length xs))

iterateN :: Int -> (a -> a) -> a -> [a]
iterateN n f x = generate
    (\xs -> (length xs) == n+1)
    (\xs -> if ((length xs) == 0) then x else (f (last xs)) )


-- -- --
--generateFromm:: ([a] -> Bool) -> ([a] -> a) -> [a] -> [a]
--generateFromm stop next xs = takeWhile (not stop) (concat (iterate (\ys -> [next ys]) xs ))
                                                            
-- -- (\xs-> if (length xs)==0 then )

-- -- :t takeWhile
-- -- takeWhile :: (a -> Bool) -> [a] -> [a]
-- -- :t iterate
-- -- iterate :: (a -> a) -> a -> [a]
