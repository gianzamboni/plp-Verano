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
listasQueSuman x = [x] : [ (x-i) : ls | i <- [1.. x-1], ls <- listasQueSuman(i) ]

--  Ejercicio 7 --
listasFinitas :: [[Int]]
listasFinitas = [ ls | i <- [1..], ls <- listasQueSuman i ]

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
    ( \xs -> if null xs then [] else [ f (head xs) ] )
    partirALaMitad
    concat

filterDC :: (a -> Bool) -> [a] -> [a]
filterDC p = dc ((<=1).length)
    (\xs -> if (null xs) || (p (head xs)) then [] else xs )
    partirALaMitad
    concat
-- Auxiliares

partirALaMitad :: [a] -> [[a]]
partirALaMitad xs = [ take i xs, drop i xs ] 
    where i = (div (length xs) 2)

merge :: Ord a => [a] -> [a] -> [a]
merge = foldr (\y rec -> (filter (<= y) rec) ++ [y] ++ (filter (>y) rec))





-- Ejercicio 10 --
-- I
sumFold :: Num a => [a] -> a
sumFold = foldr (+) 0

elemFold :: Eq a => a -> [a] -> Bool
elemFold x = foldr (\y rec -> (y==x) || rec) False

masMasFold :: [a] -> [a] -> [a]
masMasFold = flip (foldr (:))
-- -- masmas xs ys = foldr (\x rec-> x:rec) ys xs)

mapFold :: (a->b) -> [a] -> [b]
mapFold f = foldr (\x rec-> (f x):rec) []

filterFold :: (a->Bool) -> [a] -> [a]
filterFold p = foldr (\x rec -> if (p x) then x:rec else rec) []

-- II
-- --mejorSegun f [x] = x
-- --mejorSegun f (x:xs) | f x (mejorSegun f xs) = x
-- --                    | otherwise = mejorSegun f xs

mejorSegun :: (a -> a -> Bool) -> [a] -> a
mejorSegun f = foldr1 (\x rec -> if f x rec then x else rec)



-- III
sumaAlt :: Num a => [a] -> a 
sumaAlt =  foldr (-) 0

-- IV
sumaAlt2 :: Num a => [a] -> a
sumaAlt2 =  sumaAlt.reverse


-- V
permutaciones :: [a] -> [[a]]
permutaciones = foldr (\x -> concatMap (agregarEnTodasLasPosiciones x) ) [[]] 
     where agregarEnTodasLasPosiciones x xs = foldr (\i rec -> ((take i xs) ++ [x] ++ (drop i xs)) : rec) [] [0..(length xs)]



-- Ejercicio 11 --
partes :: [a] -> [[a]]
partes = foldr (\x res -> res ++ (map (x:) res)) [[]]

prefijos :: [a] -> [[a]]
prefijos = foldl (\rec x -> rec ++ [last rec ++ [x]]) [[]]

sufijos :: [a] -> [[a]]
sufijos = foldr (\x rec -> (x: head rec) : rec) [[]]

sublistas :: [a] -> [[a]]
sublistas xs = [] : filter (not.null) (subWithNull xs)
  where subWithNull = \ys -> concatMap prefijos (sufijos ys)

-- Ejercicio 12 --
recr::(a->[a]->b->b)->b->[a]->b
recr _ z [] = z
recr f z (x:xs) = f x xs (recr f z xs)

sacarUna :: Eq a => a -> [a] -> [a]
sacarUna x = recr (\y ys rec -> if (x==y) then ys else y:rec) []





-- Ejercicio 13 --
genLista :: a -> (a -> a) -> Int -> [a]
genLista x proximo n = foldr
    (\y rec ->  if null rec then
                    [x]
                else 
                    rec ++ [ proximo (last rec)])
    []
    [1.. n]

desdeHasta :: Int -> Int -> [Int]
desdeHasta x y = genLista x (+1) (y-x)





-- Ejercicio 14 --
-- I
mapPares :: (a -> b -> c) -> [(a,b)] -> [c]
mapPares f = map (uncurry f)

-- II
armarPares :: [a] -> [b] -> [(a,b)]
armarPares =
    foldr   (\x rec-> 
                (\ys -> if null ys then [] 
                        else (x,head ys):(rec (tail ys)))
            ) 
            (\ys -> []) 

armarPares' :: [a] -> [b] -> [(a,b)]
armarPares' =
    foldr
        (\x r h ->  if null h then [] else (x, head h) : (r (tail h)) )
        (\_ -> [])

-- III
mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble f as  = mapPares f.(zip as)





-- -- Ejercicio 15 --
-- I
sumaMat :: [[Int]] -> [[Int]] -> [[Int]]
sumaMat = zipWith (zipWith (+))

-- II
trasponer :: [[Int]] -> [[Int]]
trasponer [] = []
trasponer xss = foldr (zipWith (:)) [ [] | i <- [1..length (head xss)]] xss





-- Ejercicio 16 --
generate :: ([a] -> Bool) -> ([a] -> a) -> [a]
generate stop next = generateFrom stop next []

generateFrom:: ([a] -> Bool) -> ([a] -> a) -> [a] -> [a]
generateFrom stop next xs | stop xs = init xs
                          | otherwise = (generateFrom stop next (xs ++ [next xs]))

-- I
generateBase::([a] ->Bool) ->a ->(a ->a) ->[a]
generateBase stop x next = generate stop (\xs -> if (null xs) then x else (next (last xs)) ) 

-- II
factoriales::Int ->[Int]
factoriales n = 
    generate ((==n).length)
             (\xs -> if null xs then 1
                     else (last xs)*(length xs))

-- III
iterateN :: Int -> (a -> a) -> a -> [a]
iterateN n f x = generateBase ((>n).length) x f

-- IV
generateFrom1:: ([a] -> Bool) -> ([a] -> a) -> [a] -> [a]
generateFrom1 stop next = last.(takeWhile (not.stop)).(iterate (\ys -> ys ++ [next ys]))





-- Ejercicio 17 --
-- I
foldNat :: (Integer -> a -> a) -> a -> Integer -> a
foldNat _ z 0 = z
foldNat f z n = f n (foldNat f z (n-1))

-- II
potencia :: Integer -> Integer -> Integer
potencia n m = foldNat (\x -> (n*)) n (m-1)


-- Ejercicio 18 --
type Conj a = (a->Bool)

-- I
vacio :: Conj a
vacio x = False

agregar :: Eq a => a -> Conj a -> Conj a
agregar x c = (\y -> (y == x) || (c x))

-- II
interseccion :: Conj a -> Conj a -> Conj a
interseccion c1 c2 = ( \x -> (c1 x) && (c2 x) )

union :: Conj a -> Conj a -> Conj a
union c1 c2 =( \x -> (c1 x) || (c2 x) )

--III
conjuntoInfinito :: Conj a
conjuntoInfinito = (\x -> True)

-- IV
singleton :: Eq a => a -> Conj a
singleton x = (==x)

-- V
mapConjunto :: Eq b => [a] -> (a -> b) -> Conj a -> Conj b
mapConjunto xs f c = (\x -> not (null (filter (\y -> (c y) && ((f y) == x)) xs)) )


-- Ejercicio 19 --
type MatrizInfinita a = Int->Int->a

identidad :: MatrizInfinita Int
identidad = (\i j -> if i==j then 1 
                     else 0)

cantor :: MatrizInfinita Int
cantor = (\x y -> (x + y) * (x + y + 1) `div` 2 + y )

pares :: MatrizInfinita (Int, Int)
pares = (\x y -> (x, y) )

-- I
fila :: Int -> MatrizInfinita a -> [a]
fila x m = [ m x i | i <- [1..] ]

fila1::Int->MatrizInfinita a->[a]
fila1 i m = map (\j -> m i j) [1..]

columna :: Int -> MatrizInfinita a -> [a]
columna x m = [ m i x | i <- [1..] ]

columna1::Int->MatrizInfinita a->[a]
columna1 j m = map (\i -> m i j) [1..]

-- II
trasponerInfinito :: MatrizInfinita a -> MatrizInfinita a
trasponerInfinito m = (flip m)

--trasponer::MatrizInfinita a->MatrizInfinita a
--trasponer m = foldNat (\i rec -> mapDoble (:) (fila i) rec) (length [1..])


-- III
mapMatriz :: ( a -> b ) -> MatrizInfinita a -> MatrizInfinita b
mapMatriz f m = (\x y -> f (m x y))

filterMatriz :: ( a -> Bool ) -> MatrizInfinita a -> [a]
filterMatriz p m = [ m j (i-j) | i <-[0..], j <-[0..i], p (m j (i-j)) ]

zipWithMatriz :: (a->b->c) -> MatrizInfinita a -> MatrizInfinita b -> MatrizInfinita c
zipWithMatriz f m1 m2 = (\i j -> f (m1 i j) (m2 i j))

-- IV
sumaMatriz :: Num a => MatrizInfinita a -> MatrizInfinita a -> MatrizInfinita a
sumaMatriz = zipWithMatriz (+)

zipMatriz :: MatrizInfinita a -> MatrizInfinita b -> MatrizInfinita (a,b)
zipMatriz = zipWithMatriz (\x y -> (x,y))





-- Ejercicio 20 --
data AHD a b = Hoja b 
    | Rama a (AHD a b)
    | BinAHD (AHD a b) a (AHD a b) deriving Show

ahdEjemplo1 :: AHD Char String
ahdEjemplo1 = BinAHD (Hoja "hola") 'b' (Rama 'c' (Hoja "chau"))

ahdEjemplo2 :: AHD Integer Bool
ahdEjemplo2 =  (BinAHD(Rama 1 (Hoja False)) 2 (BinAHD(Hoja False) 3 (Rama 5 (Hoja True))))

-- I
foldAHD :: (a -> c -> c -> c) -> (a -> c -> c) -> (b -> c) -> AHD a b -> c
foldAHD _ _ z (Hoja e) = z e
foldAHD f g z (Rama e ar) = g e (foldAHD f g z ar)
foldAHD f g z (BinAHD ar1 e ar2) = f e (foldAHD f g z ar1) (foldAHD f g z ar2)


-- II
mapAHD :: (a -> b) -> (c -> d) -> AHD a c -> AHD b d
mapAHD f g = 
    foldAHD (\e rec1 rec2 -> BinAHD rec1 (f e) rec2)
            (\e rec -> Rama (f e) rec)
            (\e -> Hoja (g e))






-- Ejercicio 21 --
-- data AB está definida en práctica 0

-- I
foldAB :: (a -> b -> b -> b) -> b -> AB a -> b
foldAB _ z Nil = z
foldAB f z (Bin ar1 e ar2) = f e (foldAB f z ar1) (foldAB f z ar2)


-- II 
esNil :: AB a -> Bool
esNil arbol = 
    case arbol of
        Nil -> True
        Bin _ _ _ -> False

altura :: AB a -> Integer
altura = foldAB (\x rec rec1 -> 1 + rec + rec1) 0

ramas :: AB a -> [[a]]
ramas = foldAB 
    (\e rec rec1 -> if (null rec) && (null rec1) then [[e]]
                    else map (e:) (rec++rec1)
    )
    []

nodos :: AB a -> Integer
nodos = foldAB (\_ rec rec1 -> 1 + rec + rec1)
               0

hojas :: AB a -> Integer
hojas = foldAB  (\_ rec rec1 -> if (rec == 0) && (rec1 == 0) then 1
                               else rec + rec1
                )
                0

espejo :: AB a -> AB a
espejo = foldAB (\x rec rec1 -> Bin rec1 x rec)
                Nil


-- III Preguntar: Hay una forma de hacerlo u otra, cual quieren? La que hace medio trampa, como que noes recursion, solamente accedo a los elementos del constructor y en otras funciones (?)

root :: AB a -> a
root (Bin _ x _) = x

izq :: AB a -> AB a
izq (Bin i _ _) = i

der :: AB a -> AB a
der (Bin _ _ d) = d

mismaEstructura :: Eq a => AB a -> AB a -> Bool
mismaEstructura = 
    foldAB  (\x rec rec1 ->
                (\arbol ->
                    if esNil arbol then False
                    else (root arbol) == x && (rec (izq arbol)) && (rec1 (der arbol))
                )
            )
            (\arbol -> esNil arbol)


-- La puro fold

root1 :: AB a -> a
root1 = foldAB (\x _ _ -> x) undefined

izq1 :: AB a -> AB a
izq1 = foldAB (\_ rec _ -> rec) undefined

der1 :: AB a -> AB a
der1 = foldAB (\_ _ rec -> rec) undefined

mismaEstructura1 :: Eq a => AB a -> AB a -> Bool
mismaEstructura1 = 
    foldAB  (\x rec rec1 ->
                (\arbol ->
                    if esNil arbol then False
                    else (root arbol) == x && (rec (izq arbol)) && (rec1 (der arbol))
                )
            )
            (\arbol -> esNil arbol)





-- Ejercicio 22 --
-- I
data RoseTree a = Rose a [RoseTree a] deriving Show

foldRose :: (a -> [b] -> b) -> RoseTree a -> b
foldRose f (Rose x xs) = f x (map (foldRose f) xs)

hojasRT :: RoseTree a -> [a]
hojasRT = foldRose (\x recs -> if null recs then [x]
                               else  x: (concat recs))

distancias :: RoseTree a -> [(a, Integer)]
distancias = foldRose (\x recs -> if null recs then [(x,0)]
                                else map (\(t1,t2) -> (t1, t2 + 1)) (concat recs))

alturaRT :: RoseTree a -> Integer
alturaRT = foldRose (\x recs -> if null recs then 0
                              else 1 + (max recs))
    where max = mejorSegun (>)


