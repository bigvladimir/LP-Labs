#№ Отчет по лабораторной работе №4
## по курсу "Логическое программирование"

## Обработка естественного языка

### студент: Харченко В.М.

## Результат проверки

| Преподаватель     | Дата         |  Оценка       |
|-------------------|--------------|---------------|
| Сошников Д.В. |              |               |
| Левинская М.А.|              |               |

> *Комментарии проверяющих (обратите внимание, что более подробные комментарии возможны непосредственно в репозитории по тексту программы)*


## Введение 

Проблема обработки языков машиной – одна из сложнейших и первостепенных на данный момент.
Обработка языков нужна для эффективного взаимодействия человека и машины и обработки огромного потока информации, создаваемого человеком в 21 веке.
Научить машину понимать язык – крайне сложная, пока что невыполнимая задача, так как перед программистом стоит главный вопрос – как сопоставить передаваемый смысл с предложением. 
В реализации языковых алгоритмов огромную роль играют свойства, присущие тому или иному языку, так как они структурированы и могут быть запрограммированы. 
Грамматика языка – свойство того или иного языка, почти все алгоритмы обработки языков основаны на грамматиках и именно в зависимости от типа грамматики выбирается и способ обработки языка – так для регулярных автоматик применяется метод конечных автоматов, для контекстно-свободной – строится дерево грамматического разбора и т.д. 
Язык Prolog хорош для обработки языка тем, что в нем довольно легко сопоставлять различные состояния и правила, можно с легкостью находить различные паттерны, анализировать и редактировать текст.

## Задание

2. Реализовать разбор предложений английского языка. В предложениях у объекта
(подлежащего) могут быть заданы цвет, размер, положение. В результате разбора
должны получиться структуры представленные в примере.
............................................................................................................
Запросы: ?- sentence([“The”, “ big”, “ book”, “ is”, “ under”, “ the”, “ table”,X).
?- sentence([“The”, “ red”, “ book”, “ is”, “ on”, “ the”, “ table”,X).
?- sentence([“The”, “ little”, “ pen”, “ is”, “ red”,X).
Результаты: X= s(location(object(book,size(big)), under(table))),
X= s(location(object(book, color(red)), on(table))),
X= s(object(pen,size(little)), color(red)).

## Принцип решения

Разбиваем предложение на составные части: артикли, существительные, размер, цвет, предлоги.
```prolog
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
```

Задаем правила распознавания.

В зависимости от наличия составных частей, ответ будет выглядеть по-разному. 
Первым будет идти объект, с которым связаны его характеристики: цвет, размер. 
После будет идти предлог, и, если предлог указывает на место объекта в пространстве относительно другого объекта, то после характеристик выводим предлог и объект, 
относительно которого данный предлог уместен.

```prolog
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
```

## Результаты
```prolog
?- sentence([the, big, book, is, under, the, table], X).
X = s(location(object(book, size(big)), under((table))))

?- sentence([a, yellow, bottle, is, on, my, table], X).
X = s(location(object(bottle, color(yellow)), on((table))))

?- sentence([the, medium, disk, is, red], X).
X = s(object(disk, size(medium)), color(red))

?- sentence([the, big, table, is, behind, the, lamp], X).
X = s(location(object((table), size(big)), behind(lamp)))

?- sentence([the, blue, pen, is, under, the, table], X).
X = s(location(object(pen, color(blue)), under((table))))
```

## Выводы

В ходе проделанной лабораторной работы я получил навык работы с методами анализа естественно-языковых текстов. 
Язык программирования Пролог – хорош для поставленной задачи, но, я думаю, для больших масштабов скорее подойдут более быстрые языки.