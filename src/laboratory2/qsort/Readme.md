## QuickSort
- Celem tego ćwiczenia będzie zaimplementowanie algorytmu quicksort. W module qsort utwórz następujące funkcje:

- Funkcja lessThan/2, która dla listy i zadanego argumentu wybierze te elementy które są mniejsze od argumentu. 
  - Wykorzystaj list comprehensions.
  - lessThan(List, Arg) -> ... 
- Funkcja grtEqThan/2, która dla listy i zadanego argumentu wybierze te elementy które są większe bądź równe od argumentu. Tutaj też wykorzystaj list comprehensions.
  - grtEqThan(List, Arg) -> ... 
- Funkcja qs/1 implementująca algorytm quicksort:
  - qs([Pivot|Tail]) -> qs( lessThan(Tail,Pivot) ) ++ [Pivot] ++ qs( grtEqThan(Tail,Pivot) ) 

- Mając zaimplementowanego quicksorta, dobrze byłoby sprawdzić jego działanie. 
W tym celu zaimplementuj pare funkcji pomocniczych ułatwiających nam testowanie.

- Funkcja randomElems/3, która zwróci listę losowych elementów z zakresu [Min,Max] o rozmiarze N.Wykorzystaj list comprehensions oraz rand:uniform/1 i lists:seq/2.
  - randomElems(N,Min,Max)-> ... 
- Funkcja compareSpeeds/3 która porówna prędkości działania podanych algorytmów sortujących dla zadanej listy. Wykorzystaj do tego funkcję timer:tc
  - compareSpeeds(List, Fun1, Fun2) -> ... 
- Interesujące nas dane albo wypisz na standardowe wyjście poleceniem io:format/2, albo po prostu zwróć

- Następnie w Eshellu przetestuj funkcję compareSpeeds/3, używając qsort:qs1/ jak i lists:sort/1.

- Wszystkie zadania z tego punktu można wykonać w Eshellu. Dobrze jest mieć dostęp do wcześniej zaimplementowanej funkcji qsort:randomElems/3.
