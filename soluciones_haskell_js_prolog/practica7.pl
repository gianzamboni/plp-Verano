%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio N 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

padre(juan, carlos). 	%1
padre(juan, luis). 		%2	
padre(carlos, daniel).	%3
padre(carlos, diego).	%4
padre(luis, pablo).		%5
padre(luis, manuel).	%6
padre(luis, ramiro).	%7

abuelo(X,Y) :- 			%8
	padre(X,Z), 
	padre(Z,Y).


%% II.

hijo(X, Y) :- 			%9
	padre(Y, X).

hermano(X, Y) :- 		%10
	padre(Z, X), 
	padre(Z, Y),
	X \= Y.


descendiente(X, Y) :- 	%11
	hijo(X,Y).
descendiente(X,Y) :- 	%12
	hijo(X, Z),
	descendiente(Z, Y).


%% IV)
ancestro(X, X).			%13
ancestro(X, Y) :- 	%14
	padre(X, Z), 
	ancestro(Z, Y).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio N 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vecino(X, Y, [ _ | Ls ]) :- vecino(X, Y, Ls). %2
vecino(X, Y, [ X | [ Y | _ ] ] ).  %1


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio N 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
natural(0).							%1
natural(suc(X)) :- natural(X).		%2


menorOIgual(X,X) :- natural(X).						%4
menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).		%3


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio N 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%concatenar(?Lista1, ?Lista2, ?Lista3)
concatenar([], Lista2, Lista2).
concatenar([X | T1], Lista2, [X| T3]) :-
	concatenar(T1, Lista2, T3).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio N 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% I.
%last(?L, ?U)
last([ X ], X ).
last([ _ | T ], Y) :- last(T,Y).

% II.

%reverse(+L, -L1)
tienenLaMismaLongitud(L1, L2) :-
	length(L1, N ),
	length(L2, N ).

reverse([],[]).
reverse( [ X | T ], R) :-
	tienenLaMismaLongitud([X | T], R),
	last(R,X),
	reverse(T, RT ),
	append(RT, [ X ], R).

%III.
%maxLista(+L, -M)
maxLista([X], X).
maxLista([X | T], X) :-
	maxLista(T, Y),
	X >= Y.
maxLista([X | T], Y) :-
	maxLista(T, Y),
	Y >= X.

%minLista(+L, -M)
minLista([X], X).
minLista([X | T], X) :-
	minLista(T, Y),
	Y >= X.
minLista([X | T], Y) :-
	minLista(T, Y),
	X >= Y.

% IV.
%prefijo(?P, +L)
prefijo([], _).
prefijo([ X | T1 ], [ X | T2 ]) :-
	prefijo(T1, T2).

% V.
%sufijo(?S, +L)
sufijo(S, L ) :-
	prefijo(P, L),
	append(P, S, L).

% VI.
%sublista(?S, +L)
sublista([], _).
sublista([X | XS ], L) :-
	prefijo(P, L),
	sufijo(SF, L),
	append(P, [X | XS], P1),
	append(P1, SF, L).


% VII.
%pertenece(?X, +L)
pertenece(X, [X]).
pertenece(X, [ X | _]).
pertenece(X, [ Y | XS ]) :-
	X \= Y,
	pertenece(X, XS).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio N 6
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%aplanar(+XS, -YS)
aplanar([],[]).
aplanar([ [] | T ], Res) :-
	aplanar(T, Res).
aplanar([ [X | T1 ] | T ], Res) :-
	aplanar([ X | T1 ], Y),
	aplanar(T, RecT),
	append(Y, RecT, Res).
aplanar([ X | T ], [X | Res]) :-
	not(is_list(X)),
	aplanar(T, Res).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio N 7
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%palindromo(+L, -L1)
palindromo(L, L1) :-
	reverse(L, A),
	append(L,A,L1).

%doble(+L, -L1)
doble([], []).
doble([ X | T], [X, X | Rec ]) :-
	doble(T, Rec).

%iesimo(?I, +L, -X)
iesimoAux(1, [X | _], X).
iesimoAux(I, [_ | T], Y) :-
	I1 is I - 1,
	iesimo(I1, T, Y).

iesimo(I, L, X) :- 
	length(L, N),
	between(1,N, I),
	iesimoAux(I, L, X).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio N 8
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
desde(X,X).
desde(X,Y) :- N is X+1, desde(N,Y).

%desde2(+X,?Y)
desde2(X, Y) :- 
	nonvar(Y),
	Y >= X.
desde2(X,Y) :-
	var(Y),
	desde(X,Y).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio N 9
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% I.

%interseccionAux(+L1, +L2, +L3, -L4)
interseccionAux([], _, _, []).
interseccionAux([ X | T ], L2, Usados, Resultado) :-
	not(member(X, L2)),
	interseccionAux(T, L2, Usados, Resultado).
interseccionAux([ X | T ], L2, Usados, [ X | L4 ]) :-
	member(X, L2),
	not(member(X, Usados)),
	interseccionAux(T, L2, [ X | Usados], L4).
interseccionAux([ X | T ], L2, Usados, L4 ) :-
	member(X, Usados),
	interseccionAux(T, L2, Usados, L4).

%intersección(+L1, +L2, -L3)
interseccion(L1, L2, L3) :-
	interseccionAux(L1, L2, [], L3).

%II.
%split(+N,+L, -L1, -L2) -- N y L deben estar definidos

sufijoDeLongitud(L, N, S) :-
	sufijo(S, L),
	length(S, N).

prefijoDeLongitud(L, N, S) :-
	sufijo(S, L),
	length(S, N).

split(N, L, L1, L2) :-
	length(L, M),
	N1 is M - N,
	prefijoDeLongitud(L, N, L1),
	sufijoDeLongitud(L, N1, L2).

% III.
%borrar(+ListaOriginal, +X, -ListaSinXs)
borrar([], _, []).
borrar([X | T], X, ListaSinXs) :-
	borrar(T, X, ListaSinXs).
borrar([ Y | T], X, [ Y | Rec ]) :-
	X \= Y,
	borrar(T, X, Rec).

% IV.
%sacarDuplicados(+L1, -L2)
sacarDuplicados([], []).
sacarDuplicados([ X | T], [ X | Rec ]) :-
	borrar(T, X, T1),
	sacarDuplicados(T1, Rec).

%V.
%concatenarTodas( +LL, -L)
concatenarTodas([], []).
concatenarTodas([ X | T], Res) :-
	concatenarTodas(T, Rec),
	concatenar(X, Rec, Res).

%todosSusMiembrosSonSublitas(+LListas, +L)
todosSusMiembrosSonSublitas([], _).
todosSusMiembrosSonSublitas([ X | XS], L) :-
	sublista(X, L),
	todosSusMiembrosSonSublitas(XS, L).
%reparto(+L, +N, -LListas)
reparto(L, N, LListas) :-
	length(LListas, N),
	todosSusMiembrosSonSublitas(LListas, L),
	concatenarTodas(LListas, L).

%VI.
%repartoSinVacias(+L, -LListas)
repartoSinVacias(L, LListas) :-
	length(L, N),
	between(1, N, X),
	reparto(L, X, LListas),
	not(member([], LListas)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio N 10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%intercalar(?L1, ?L2, ?L3) -- Funciona para todas las combinaciones posibles.
intercalar([], L, L).
intercalar(L, [], L).
intercalar([ X | T1], [ Y | T2 ], [ X, Y | T3 ] ) :-
	intercalar(T1, T2, T3).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio N 11
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%arbolEjemplo
arbolEjemplo(bin(bin(nil,1,nil),2,bin(bin(nil,10,nil),20,bin(nil,30,nil)))).

%vacio(?A)
vacio(nil).

%raiz(?A, ?R)
raiz(bin(_,X,_), X).

%altura(+A, -H)
altura(nil, 0).
altura(bin(I, _, D), H) :-
	altura(I, HI),
	altura(D, HD),
	H is max(HI, HD) + 1.

%cantidadDeNodos(+A, -N)
cantidadDeNodos(nil, 0).
cantidadDeNodos(bin(I, _, D), N) :-
	cantidadDeNodos(I, NI),
	cantidadDeNodos(D, ND),
	N is NI + ND + 1.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio N 12
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%inorder(+AB, -Lista)
inorder(nil, []).
inorder(bin(I, X, D), Inorder) :-
	inorder(I, LI),
	inorder(D, LD),
	append(LI, [X | LD], Inorder).

%arbolConInorder(-L, +AB)
arbolConInorder([], nil).
arbolConInorder(XS, bin(AI, X, AD)) :-
	reparto(XS, 2, [LI, [X | LD]]),
	arbolConInorder(LI, AI),
	arbolConInorder(LD, AD).

%abb(+T)
aBB(nil).
aBB(bin(I, _, D)) :-
	aBB(I),
	aBB(D).

%aBBInsertar(+X, +T1, -T2)
aBBInsertar(X, nil, bin(nil, X, nil)).
aBBInsertar(X, bin(AI, Y, AD), bin(AIM, Y, AD)) :-
	X =< Y,
	aBBInsertar(X, AI, AIM).
aBBInsertar(X, bin(AI, Y, AD), bin(AI, Y, ADM)) :-
	X >= Y,
	aBBInsertar(X, AD, ADM).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio N 13
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%coprimos(-X,-Y)
coprimos(X,Y) :-
	desde(2, X),
	between(2, X, Y),
	1 is gcd(X,Y).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio N 14
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
listasQueSuman([],0,0).
listasQueSuman([X|XS],S,N):-
    between(0,S,X),
    N2 is N-1,
    length(XS,N2), 
    S2 is S-X, 
    listasQueSuman(XS,S2,N2).

cuadradoSemiLatinoAux(_,0,[],_).
cuadradoSemiLatinoAux(M,N,[X|XS],S):- 
	N2 is N-1, 
	listasQueSuman(X,S,M),
	cuadradoSemiLatinoAux(M,N2,XS,S).

cuadradoSemiLatino(N,XS):-
	length(XS,N),
	desde(0,S),
	cuadradoSemiLatinoAux(N,N,XS,S).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio N 15
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ladoValido(+A, +B, +C)
ladoValido(A,B,C) :-
	S is B+C,
	A < S,
	D is abs(B-C),
	A > D.

%esTriangulo(+T)
esTriangulo(tri(A,B,C)) :-
	ladoValido(A,B,C),
	ladoValido(B,C,A),
	ladoValido(C,A,B).

%perı́metro(?T,?P)
perimetro(tri(A,B,C), P) :-
	desde2(3,P),
	M is P-2,
	between(1,M,A),
	N is P - A -1,
	between(1, N, B),
	C is P - A - B,
	esTriangulo(tri(A,B,C)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio N 16
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%diferenciaSimétrica(Lista1, +Lista2, -Lista3)
diferenciaSimetrica([], L2, L2).
diferenciaSimetrica([ X | L1], L2, [ X | XS]) :-
	not(member(X, L2)),
	diferenciaSimetrica(L1, L2, XS).
diferenciaSimetrica([ X | L1], L2, XS) :-
	member(X, L2),
	borrar(L2, X, L2SinX),
	diferenciaSimetrica(L1, L2SinX, XS).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio N 18
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%sumList
sumList([], 0).
sumList([X | XS], N) :-
	sumList(XS, N1),
	N is N1 + X.

%diff
diff(L1, L2, DL) :-
	sumList(L1, N1),
	sumList(L2, N2),
	DL is abs(N1-N2).

%corteMásParejo(+L,-L1,-L2)
corteMasParejo(L, L1, L2) :-
	append(L1, L2, L),
	diff(L1,L2,DL),
	not((append(M1,M2,L), 
		diff(M1,M2,DM),
		DM < DL
		)).