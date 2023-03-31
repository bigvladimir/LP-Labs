parent_for_both(X, Y, Z):-
	father(Z, X),
	father(Z, Y).
parent_for_both(X, Y, Z):-
	mother(Z, X),
	mother(Z, Y).

sex(X, m):-
	father(X, _).
sex(X, f):-
	mother(X, _).

brother(X, Y):-
	sex(X, m),
	parent_for_both(X, Y, _),
	X \= Y.

sister(X, Y):-
	sex(X, f),
	parent_for_both(X, Y, _),
	X \= Y.

aunt(A,X):-
	father(Z, X),
	sister(A, Z).
aunt(A,X):-
	mother(Z, X),
	sister(A, Z).

uncle(A,X):-
	father(Z, X),
	brother(A, Z).
uncle(A,X):-
	mother(Z, X),
	brother(A, Z).

% X кузен Y
cousin(X, Y):-
	uncle(Z, X),
	father(Z, Y).
cousin(X, Y):-
	aunt(Z, X),
	mother(Z, Y).

% X троюродный(ая) брат(сестра) Y
% родитель X и родитель Y должны быть кузенами
second_cousin(X, Y):-
	father(A, Y),
	father(B, X),
	cousin(A, B).
second_cousin(X, Y):-
	mother(A, Y),
	father(B, X),
	cousin(A, B).
second_cousin(X, Y):-
	father(A, Y),
	mother(B, X),
	cousin(A, B).
second_cousin(X, Y):-
	mother(A, Y),
	mother(B, X),
	cousin(A, B).