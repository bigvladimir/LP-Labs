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

aunt(A, X):-
	father(Z, X),
	sister(A, Z).
aunt(A, X):-
	mother(Z, X),
	sister(A, Z).

uncle(A, X):-
	father(Z, X),
	brother(A, Z).
uncle(A, X):-
	mother(Z, X),
	brother(A, Z).

cousin(X, Y):-
	uncle(Z, X),
	father(Z, Y),
	sex(Y,m), !.
cousin(X, Y):-
	aunt(Z, X),
	mother(Z, Y),
	sex(Y,m), !.

second_cousin(X, Y):-
	father(A, Y),
	father(B, X),
	cousin(A, B), !.
second_cousin(X, Y):-
	mother(A, Y),
	father(B, X),
	cousin(A, B), !.
second_cousin(X, Y):-
	father(A, Y),
	mother(B, X),
	cousin(A, B), !.
second_cousin(X, Y):-
	mother(A, Y),
	mother(B, X),
	cousin(A, B), !.

grandson_search(X, Y):-
	father(Z, X),
	father(Y, Z).

grandson_search(X, Y):-
	mother(Z, X),
	father(Y, Z).

grandson(X, Y):-
	sex(X, 'm'),
	grandson_search(X, Y).

granddaughter(X, Y):-
	sex(X, 'f'),
	grandson_search(X, Y).

parent(X, Y):-
	father(X, Y).
parent(X, Y):-
	mother(X, Y).

son(X, Y):-
	sex(X, 'm'),
	parent(Y, X).

daughter(X, Y):-
	sex(X, 'f'),
	parent(Y, X).

grandfather(X, Y):-
	father(X, Z),
	parent(Z, Y).

grandmother(X, Y):-
	mother(X, Z),
	parent(Z, Y).

husband(X, Y):-
	father(X, Z),
	mother(Y, Z).

wife(X, Y):-
	mother(X, Z),
	father(Y, Z).

% тривиальный случай
relative('father', X, Y):- father(X, Y).
relative('mother', X, Y):- mother(X, Y).
relative('brother', X, Y):- brother(X, Y).
relative('sister', X, Y):- sister(X, Y).
relative('husband', X, Y):- husband(X, Y).
relative('wife', X ,Y):- wife(X, Y).
relative('son', X, Y):- son(X, Y).
relative('daughter', X, Y):- daughter(X, Y).
relative('grandson', X, Y):- grandson(X, Y).
relative('granddaughter', X, Y):- granddaughter(X, Y).
relative('grandfather', X, Y):- grandfather(X, Y).
relative('grandmother', X, Y):- grandmother(X, Y).
relative('aunt', X, Y):- aunt(X, Y).
relative('uncle', X, Y):- uncle(X, Y).
relative('cousin', X, Y):- cousin(X, Y).
relative('second cousin', X, Y):- second_cousin(X, Y).

relative(W, X, Y):- 
	dfs(X, Y, W).

% перевод списка имён в список отношений
translator([X, Y], [R]):-
	relative(R, X, Y).
translator([X, Y|T], [P, Q|R]):-
	relative(P, X, Y),
	translator([Y|T], [Q|R]), !.

move(X, Y):-
	father(X, Y);
	mother(X, Y);
	brother(X, Y);
	sister(X, Y);
	son(X, Y);
	daughter(X, Y);
	husband(X, Y);
	wife(X, Y),
	grandfather(X, Y),
	grandmother(X, Y),
	grandson(X, Y),
	granddaughter(X, Y),
	aunt(X, Y),
	uncle(X, Y),
	cousin(X, Y).

prolong([X|T], [Y, X|T]):-
	move(X, Y),
	not(member(Y, [X|T])).
path1([X|T], X, [X|T]).
path1(L, Y, R):-
	prolong(L, T),
	path1(T, Y, R).
dfs(X, Y, R2):-
	path1([X], Y, R1),
	translator(R1, R2).
