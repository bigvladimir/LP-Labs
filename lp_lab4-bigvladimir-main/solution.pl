art(a).
art(an).
art(the).

item(book).
item(disk).
item(lamp).
item(pen).
item(bottle).
item(table).

color(red).
color(green).
color(blue).
color(yellow).
color(orange).

size(little).
size(medium).
size(big).

location(in, X, in(X)).
location(on, X, on(X)).
location(under, X, under(X)).
location(behind, X, behind(X)).
location(before, X, before(X)).
location(after, X, after(X)).

sentence([H], s(H)).
sentence([A, B], s(A, B)).

sentence([Art, Size, Item | T], Res):-
    art(Art),
    size(Size),
    item(Item),
    sentence([object(Item, size(Size)) | T], Res).

sentence([Art, Color, Item | T], Res):-
    art(Art),
    color(Color),
    item(Item),
    sentence([object(Item, color(Color)) | T], Res).

sentence([object(Item, size(Size)), is, X, Y, Z | T], Res):-
    art(Y),
    item(Z),
    location(X, Z, Loc),
    sentence([location(object(Item, size(Size)), Loc) | T], Res).

sentence([object(Item, color(Color)), is, X, Y, Z | T], Res):-
    art(Y),
    item(Z),
    location(X, Z, Loc),
    sentence([location(object(Item, color(Color)), Loc) | T], Res).

sentence([object(Item, size(Size)), is, X | T], Res):-
    color(X),
    sentence([object(Item, size(Size)), color(X) | T], Res).

sentence([object(Item, color(Color)), is, X | T], Res):-
    size(X),
    sentence([object(Item, color(Color)), size(X) | T], Res).