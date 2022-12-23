% The line below imports the data
:- ['two.pl'].

lenght([], 0).
lenght([_|H], N) :- lenght(H,N1), N is N1 + 1.

sum([], 0).
sum([Y|H], N) :- sum(H,N1), N is Y + N1.

?- write('Средний балл для каждого предмета'),nl.
?- findall(X,grade(_,_,'Логическое программирование',X),C), lenght(C,N), sum(C,S), write(S/N),nl.
?- findall(X,grade(_,_,'Математический анализ',X),C), lenght(C,N), sum(C,S), write(S/N),nl.
?- findall(X,grade(_,_,'Функциональное программирование',X),C), lenght(C,N), sum(C,S), write(S/N),nl.
?- findall(X,grade(_,_,'Информатика',X),C), lenght(C,N), sum(C,S), write(S/N),nl.
?- findall(X,grade(_,_,'Английский язык',X),C), lenght(C,N), sum(C,S), write(S/N),nl.
?- findall(X,grade(_,_,'Психология',X),C), lenght(C,N), sum(C,S), write(S/N),nl.

?- write('Количество не сдавших студентов для каждой группы'),nl.
?- findall(2,grade(101,_,_,2),C), lenght(C,N), write(N),nl.
?- findall(2,grade(102,_,_,2),C), lenght(C,N), write(N),nl.
?- findall(2,grade(103,_,_,2),C), lenght(C,N), write(N),nl.
?- findall(2,grade(104,_,_,2),C), lenght(C,N), write(N),nl.

?- write('Количество не сдавших студентов для каждого из предметов'),nl.
?- findall(2,grade(_,_,'Логическое программирование',2),C), lenght(C,N), write(N),nl.
?- findall(2,grade(_,_,'Математический анализ',2),C), lenght(C,N), write(N),nl.
?- findall(2,grade(_,_,'Функциональное программирование',2),C), lenght(C,N), write(N),nl.
?- findall(2,grade(_,_,'Информатика',2),C), lenght(C,N), write(N),nl.
?- findall(2,grade(_,_,'Английский язык',2),C), lenght(C,N), write(N),nl.
?- findall(2,grade(_,_,'Психология',2),C), lenght(C,N), write(N),nl.