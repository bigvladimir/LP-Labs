lenght([], 0). % длина списка
lenght([_|H], N) :- lenght(H,N1), N is N1 + 1.

member(X, [X|_]). % принадлежность списку
member(X,[_|Y]) :- member(X,Y).

append([],X,X). % добавление элемента
append([A|X],Y,[A|Z]) :- append(X,Y,Z).

remove(X,[X|Y],Y). % удаление элемента
remove(X,[Y|T],[Y|T1]) :- remove(X,T,T1).

permute([],[]). %  генерация возможных вариантов
permute(L, [X|T]) :- remove(X,L,R), permute(R,T).

sublist(S,L) :- append(_,L1,L),append(S,_,L1).

% Удаление трех последних элементов
delete([_,_,_],[]).
delete([X|Y], [X|Z]) :- delete(Y,Z).

remove_3(L, X) :- append(X,A,L), lenght(A,3).

% Проверка упорядоченности элементов по возрастанию
sequence([_]).
sequence([X,Y|Z]) :- X<Y, sequence([Y|Z]).

sequence1([X,Y|Z]) :- not(lenght(Z,0)), X<Y, sequence([Y|Z]).
