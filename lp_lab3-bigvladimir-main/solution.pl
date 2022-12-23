%?-solve_g(["b","b","b","b","_","w","w","w"],["w","w","w","_","b","b","b","b"],X).
%?-solve_sh(["b","b","b","b","_","w","w","w"],["w","w","w","_","b","b","b","b"],X).
%?-solve_it(["b","b","b","b","_","w","w","w"],["w","w","w","_","b","b","b","b"],X).
%?-time(solve_g(["b","b","b","b","_","w","w","w"],["w","w","w","_","b","b","b","b"],X)).
%?-time(solve_sh(["b","b","b","b","_","w","w","w"],["w","w","w","_","b","b","b","b"],X)).
%?-time(solve_it(["b","b","b","b","_","w","w","w"],["w","w","w","_","b","b","b","b"],X)).


my_member(X, [X|_]).
my_member(X,[_|Y]) :- member(X,Y).

my_append([],X,X).
my_append([A|X],Y,[A|Z]) :- append(X,Y,Z).

my_reverse(L,Z) :- buf(L,[],Z).
buf([],Result,Result).
buf([X|Y],Result,Z) :- buf(Y,[X|Result],Z).

prolong([A|P],[C,A|P]) :- move(A,C).

move(A,C) :-
	my_append(X,["_","w"|Y],A), my_append(X,["w","_"|Y],C);
	my_append(X,["b","_"|Y],A), my_append(X,["_","b"|Y],C);
	my_append(X,["_","b","w"|Y],A), my_append(X,["w","b","_"|Y],C);
	my_append(X,["b","w","_"|Y],A), my_append(X,["_","w","b"|Y],C).


%поиск в глубину%

solve_g(A,B,H) :- path_g([A],B,L), my_reverse(L,H).

path_g([B|P],B,[B|P]).
path_g(A,B,H) :- prolong(A,C), path_g(C,B,H).


%поиск в ширину%

solve_sh(A,B,G):- path_sh([[A]],B,L), my_reverse(L,G).

path_sh([[B|P]|_],B,[B|P]).
path_sh([A|P],B,G) :- findall(P1,prolong(A,P1),L), my_append(P,L,C), !, path_sh(C,B,G).
path_sh([_|P],B,G) :- path_sh(P,B,G).


%поиск в глубину с итеративным погружением для нахождения кратчайшего пути%

solve_it(S,F,P) :- search_id(S,F,K), my_reverse(K,P).

search_id(S,F,P) :- my_integer(Level), search_id(S,F,P,Level).

my_integer(1).
my_integer(M) :- my_integer(N), M is N+1.

search_id(S,F,P,DL) :- path_g([S],F,P,DL).

path_g([B|P],B,[B|P],0).
path_g(A,B,H,N) :- N > 0, prolong(A,C), N1 is N-1, path_g(C,B,H,N1).