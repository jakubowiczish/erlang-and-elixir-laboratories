# Laboratorium nr 1 - podstawy języka Erlang

## Uruchom program Eshell
- Przetestuj działanie podstawowych elementów składni:
- Wyrażenia arytmetyczne na liczbach całkowitych i zmiennoprzecinkowych
  - 2+4. 4+4.0.
  - 2 / 0.
  - 4 div 3. 4.0 rem 1.1.
  - Zmienne
  - A = 2 + 2. B = A + 2.
  - C = ala. D = makota.
  - 6 = B.
  - B = 12.
- Operatory logiczne
- B == 6. A =:= B.
- Krotki i listy
- Utwórz zmienne P1, P2, P3 związane ze strukturami, które przechowują informacje o produktach w sklepie z zabawkami. Każda ma zawierać typ, nazwę i inne właściwości, takie jak cena, waga, kolor itp.
- Utwórz zmienną ListaProduktow związaną z listą produktów.
- Utwórz jeszcze jedną zmienną P4 związaną z innym produktem
- Wykorzystując tylko zmienne ListaProduktow oraz P4 utwórz listę NowaListaProduktow zawierającą wszystkie produkty. Użyj definicji rekurencyjnej listy.
- Napisz wyrażenie, które ze zmienną NazwaP1 zwiąże nazwę produktu opisywanego w zmiennej P1.
- Makra powłoki, funkcje wbudowane i moduły standardowe
- f(). - czyści wszystkie wiązania zmiennych.
- time(). Zwiąż zmienną o nazwie Minutki z aktualną minutą.
- list_to_tuple(ListaProduktow).
- io:format(„Produkt w sklepie nazywa się ~p.~nAktualna minutka to ~B.~n”, [NazwaP1, Minutki] ).
## Moduły i funkcje
- Przygotuj środowisko
- Uruchom środowisko IntelliJ.
- Utwórz nowy projekt typu „Erlang”, a w projekcie nowy plik z kodem.
- Wtyczka powinna podświetlać składnię i wyświetlać opisy błędów…
- W module zaimplementuj funkcję power/2, która podniesie pierwszy argument do potęgi podanej w drugim parametrze.
- Przetestuj moduł w konsoli IntelliJ:
- Utwórz konfigurację uruchamiania „Erlang Console”,
- Dodaj w niej akcję „Build” przed uruchomieniem,
- Zapisz i uruchom; przetestuj działanie funkcji.
- Utwórz nowy moduł o nazwie myLists. Zaimplementuj i przetestuj funkcje:
- contains/2, która jako parametry weźmie listę i wartość, i zwróci true jeśli lista zawiera wartość.
- duplicateElements/1, która zwróci listę zawierającą każdy z elementów dwukrotnie - [A, B, …] zmienia w [A, A, B, B, …].
- sumFloats/1, która zsumuje elementy będące liczbami zmiennoprzecinkowymi.
- Zmodyfikuj funkcję sumFloats/1 by korzystała z rekurencji ogonowej.

## Kalkulator ONP 
http://pl.wikipedia.org/wiki/Odwrotna_notacja_polska
- zapisz w onp następujące wyrażenia :
  - 1 + 2 * 3 - 4 / 5 + 6
  - 1 + 2 + 3 + 4 + 5 + 6 * 7
  - ( (4 + 7) / 3 ) * (2 - 19)
  - 17 * (31 + 4) / ( (26 - 15) * 2 - 22 ) - 1

- utwórz moduł onp z funkcją onp/1, która dla poprawnego wyrażenia ONP zwróci wynik
- funkcja powinna obsługiwać operacje +, -, *, / oraz liczby całkowite
- do parsowania wyrażenia wykorzystaj funkcję string:tokens/2
- do konwertowania ciągów znaków na liczby wykorzystaj funkcję list_to_integer/1
- sprawdź działanie dla zapisanych wyrażeń (http://lidia-js.kis.p.lodz.pl/LM_lab/cwiczenia.php?id=oblicz_onp)
## Zadanie domowe
- Dokończ zadania z zajęć.
- Dodaj do kalkulatora operacje sqrt, pow i funkcje trygonometryczne
- Dodaj do kalkulatora obsługę liczb zmiennoprzecinkowych w wyrażeniach
