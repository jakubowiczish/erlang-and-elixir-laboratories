# Laboratorium nr 2 - programowanie funkcyjne w Erlangu

## Przebieg zajęć

Na dzisiejszych zajęciach poznamy funkcyjne sposoby rozwiązywania problemów w Erlangu. 

Wykorzystamy do tego list comprehensions jak i funkcje wyższego rzędu.

Część problemów do których rozwiązania używamy pętli for czy while można również wyrazić za pomocą powyższych narzędzi. 

Każde z nich jest w stanie wyrazić inną rodzine problemów.

## Rozgrzewka

Eshell

```erlang
%%Proste list comprehensions.
>[X*2 ||  X<- lists:seq(1,10), X rem 2 == 0].
 
%%Definicja funa.
> Hello = fun(X) -> io:format("Hello ~s~n", [X]) end.
%%Wywołanie funa.
> Hello("World").
 
%%Fun jako argument funkcji wyższego rzędu
> Add1 = fun(X) -> X + 1 end.
%Co zwrócą poniższe wyrażenia ?
> lists:map(Add1, [1,2,3]).
> lists:map(fun(X) -> X+2 end, [1,2,3]).
> lists:map(fun math:sqrt/1, [1,2,3]).
 
%%Zdefiniuj własnego funa, który mnoży dany argument razy 2.
> Multi2 = ...
% I przetestuj tak jak powyżej
> lists:map(?, ?).
```

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

## Fun
- Zaimplementuj samodzielnie funkcje wyższego rzędu map/2 oraz filter/2.
- Przetestuj powyższe funkcje.
- Stwórz funkcję, która policzy sumę cyfr w liczbie. Użyj do tego lists:foldl/3.
- Przy pomocy funkcji lists:filter/2 wybierz z listy miliona losowych liczb takie, w których suma cyfr jest podzielna przez 3.

## Pollution
- Utwórz nowy moduł o nazwie pollution, który będzie zbierał i przetwarzał dane ze stacji mierzących jakość powietrza. 
- Moduł powinien przechowywać:
  - informacje o stacjach pomiarowych,
  - współrzędne geograficzne,
  - nazwy stacji pomiarowych,
  - zmierzone wartości pomiarów, np stężenia pyłów PM10, PM2.5 czy wartości temperatury (wraz z datą i godziną pomiaru).

- Nie powinno być możliwe:
  - dodanie dwóch stacji pomiarowych o tej samej nazwie lub tych samych współrzędnych;
  - dodanie dwóch pomiarów o tych samych:
  - współrzędnych,
  - dacie i godzinie,
  - typie (PM10, PM2.5, temperatura, …);
  - dodanie pomiaru do nieistniejącej stacji.

- Zaprojektuj strukturę danych dla przechowywania takich informacji (jest przynajmniej kilka dobrych rozwiązań tego problemu).

- Zaimplementuj funkcje w module pollution:
  - createMonitor/0 - tworzy i zwraca nowy monitor zanieczyszczeń;
  - addStation/3 - dodaje do monitora wpis o nowej stacji pomiarowej (nazwa i współrzędne geograficzne), zwraca zaktualizowany monitor;
  - addValue/5 - dodaje odczyt ze stacji (współrzędne geograficzne lub nazwa stacji, data, typ pomiaru, wartość), zwraca zaktualizowany monitor;
  - removeValue/4 - usuwa odczyt ze stacji (współrzędne geograficzne lub nazwa stacji, data, typ pomiaru), zwraca zaktualizowany monitor;
  - getOneValue/4 - zwraca wartość pomiaru o zadanym typie, z zadanej daty i stacji;
  - getStationMean/3 - zwraca średnią wartość parametru danego typu z zadanej stacji;
  - getDailyMean/3 - zwraca średnią wartość parametru danego typu, danego dnia na wszystkich stacjach;

- W funkcjach używaj następujących typów i formatów danych:
  - do przechowywania dat użyj struktur z modułu calendar (zob. calendar:local_time(). ),
  - współrzędne geograficzne to para (krotka) liczb,
  - nazwy, typy to ciągi znaków.

- Przetestuj działanie modułu.
  - P = pollution:createMonitor().
  - P1 = pollution:addStation(„Aleja Słowackiego”, {50.2345, 18.3445}, P).
  - P2 = pollution:addValue({50.2345, 18.3445}, calendar:local_time(), „PM10”, 59, P1).
  - P3 = pollution:addValue(„Aleja Słowackiego”, calendar:local_time(), „PM2,5”, 113, P2).

- Zabezpiecz moduł pollution - będzie on potrzebny na następnych zajęciach.

## Zadanie domowe
- Dokończ moduł pollution.
- Napisz testy do modułu pollution z wykorzystaniem EUnit. - to zrobimy później
- Niespodzianka :)
