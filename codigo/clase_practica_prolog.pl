natural(cero)
natural(succ(n)) :- natural(N)

siguiente(Cero, suc(Cero))
siguiente(A, suc(A))