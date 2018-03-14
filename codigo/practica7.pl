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
%maximo()
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
