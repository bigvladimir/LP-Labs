#№ Отчет по лабораторной работе №2
## по курсу "Логическое программирование"

## Решение логических задач

### студент: Харченко В.М.

## Результат проверки

| Преподаватель     | Дата         |  Оценка       |
|-------------------|--------------|---------------|
| Сошников Д.В. |              |               |
| Левинская М.А.|              |               |

> *Комментарии проверяющих (обратите внимание, что более подробные комментарии возможны непосредственно в репозитории по тексту программы)*


## Введение

Эффетивный способ решений логических задач - предположение о том, что какой-то факт верный и получение либо противоречия, либо успеха. Так же используются построения таблиц истинности для задач. Программа на языке Prolog решит описанную задачу полным перебором, основываясь на имеющихся фактах.

## Задание

Вариант 21:

Дима, Герман и Олег студенты. Каждый из них увлекается тремя предметами из четырех: биологией, химией, историей, математикой. Вот что они говорили о своих склонностях. Герман. Дима единственный из нас, кто любит историю. Олег и я увлекаемся одними и теми же предметами. Мы все считаем биологию интереснейшей наукой. Двое из нас любят и химию, и биологию. Олег. Нам всем очень нравится математика. Герман завзятый историк. В одном из увлечений мы расходимся с Димой. Герман и Дима любят химию. Дима. Есть только один предмет, который любим мы все. Математикой увлекаюсь я один. Каждый из нас любит разное сочетание дисциплин. Олег ошибается, говоря, что Герман и я увлекаемся химией. Известно, что только два из утверждений каждого студента соответствуют действительности. Попробуйте сказать, какими науками увлекается каждый из них?

## Принцип решения

G, O, D – студенты Герман, Олег и Дима соответсвенно.

Т.к. было 3-е студентов и 3 предмета, которыми они увлекались, из 4-х возможных, то следующим предикатом я делал перебор комбинаций из 3-х предметов:

my_remove(_,[biology,history,chemistry,math],G).

Далее, нужно было так же пройтись по всем вариантам 2 верных утверждение и 2 неверных у каждого из говорящих:

check(N,S):-

my_remove(T1,[1,2,3,4],R), my_remove(T2,R,[L1,L2]),

say(N,T1,S), say(N,T2,S), not(say(N,L1,S)), not(say(N,L2,S)).

Соответственно, наши высказывания должны выглядеть так: первый аргумент – кто из студентов говорит, второй – номер его высказывания, третий – список списков (сгенерированные три предмета для каждого из трех участников). Для Германа это будет выглядеть следующим образом:

say(g,1,[G,O,D]) :- my_member(history, D), not(my_member(history, G)), not(my_member(history, O)).

say(g,2,[G,O,_]) :- my_member(P1, G), my_member(P1, O),

    my_member(P2, G), my_member(P2, O),

    my_member(P3, G), my_member(P3, O), P3\=P2, P2\=P1, P3\=P1.

say(g,3,[G,O,D]) :- my_member(biology, G), my_member(biology, O),my_member(biology, D).

say(g,4,[G,O,_]) :- my_member(biology,G), my_member(chemistry,G),

    my_member(biology,O), my_member(chemistry,O).

say(g,4,[G,_,D]) :- my_member(biology,G), my_member(chemistry,G),

    my_member(biology,D), my_member(chemistry,D).

say(g,4,[_,O,D]) :- my_member(biology,O), my_member(chemistry,O),

    my_member(biology,D), my_member(chemistry,D).

Для проверки истинности высказывания (увлекается ли данный человек тем или иным предметом) использовался предикат member() или not(member()) – для не увлечения.

## Выводы

Сложность реализованного алгоритма О(n), тк выборка в предикатах my_remove, my_member осуществляется за один проход. Умение реализовывать данного типа программы поможет сэкономить время разработчику. Самым сложным было понять как реализовать перебор вариантов. Так же данная лабораторная работа помогла более подробно разобраться со стандартными предикатами и отрицанием.