#### Przed zajęciami... warto zapoznać się z

- Składnią Elixira.

- Zmienne, atomy, krotki, listy, mapy, …

- Podstawowe operatory matematyczne, logiczne, …

- Moduły, funkcje, …

- Uruchamianiem i testowaniem programów i iex

- Zaimplementuj i przetestuj w domu prosty moduł który zawiera funkcję liczącą silnię.


##### Przebieg zajęć

W ramach zajęć zrealizujemy funkcjonalność parsowania danych o zanieczyszczeniu powietrza
 z pliku i ich ładowania do modułu pollution_server. 
 
Plik zawiera w kolejnych wierszach następujące dane:

```
03-05-2017,00:02,19.992,50.081,96
03-05-2017,00:58,19.727,49.989,94
03-05-2017,00:15,19.678,49.989,76
```
czyli:

```
DATA,GODZINA,DLUGOSC,SZEROKOSC,WARTOSC
```
### Import z pliku. 

##### W nowym module PollutionData utwórz funkcję importLinesFromCSV.
 
Przydadzą się:
```elixir
File.read!(„file.txt”)

String.split(„string”, „delimiter”)

warto użyć: 

File.read!(…) |> String.split(…)

length(list) - w pliku jest nieco ponad 5900 wpisów, sprawdź czy tyle się załadowało
```

### Parsowanie danych. 

##### Napisz funkcję konwertującą jedną linijkę danych do postaci:
 
 %{:datetime ⇒ {{2017,5,22},{13,23,30}}, :location ⇒ {19.992,50.081}, :pollutionLevel ⇒ 96}.
  
Przydadzą się:
```elixir
[pattern, matching, on, list] = String.split(…
Enum.reverse

Enum.map(list, fn)

Integer.parse(„1234”), Float.parse(„1234.3”)

elem(tuple,0)

:erlang.list_to_tuple

… tu również warto użyć:
 
 date |> …split… |> …reverse… |> …map(elem(parse))…
```

### Identyfikacja stacji pomiarowych.
 
Dane załadowane do struktur trzeba przeanalizować w celu wykrycia stacji pomiarowych.
 
##### Utwórz funkcję identifyStations, która zwróci dane potrzebne do utworzenia stacji.
 
Można to zrobić z użyciem mapy, nadpisując klucze dla tych samych współrzędnych.
 
 Pomogą:
```elixir
Enum.reduce(list, %{}, fn reading, acc → acc end)

Map.put(mapa, :key, „value”)

tu również: list |> reduce(… put…)
```
ile jest unikatowych stacji w danych?

### Ładowanie danych stacji. 

##### Uruchom serwer i utwórz w nim stacje, generując ich nazwy w postaci „station_longitude_latitude”.
 
 Przyda się:
 ```elixir
:pollutionSupervisor.start_link()
string = „ala ma #{catsCount} kotow”
```
### Ładowanie danych pomiarów.
 
Załaduj dane wszystkich pomiarów, przyjmując rodzaj zanieczyszczeń jako „PM10”. 

Zmierz czas ładowania, wyniki wpisz do arkusza.
 
 Można użyć:
 ```elixir
fn |> :timer.tc |> elem(0)
```

### Analiza danych.
 
##### Zmierz wartości wybranych analiz parametrów zanieczyszczeń i wpisz je do arkusza.
  
Przetestuj wszystkie funkcje analizujące w swojej implementacji, korzystając z przykładowych wywołań w arkuszu 
(jesli brakuje przykładu, dodaj go).

### Modyfikacja ładowania. 

Na kopii modułu przeprowadź refaktoring, który wprowadzi wykorzystanie strumieni w ładowaniu danych. 

Porównaj czas ładowania. 

Wykorzystaj:

```elixir
File.stream!(filename)

Stream.map, Stream.flat_map, Stream.filter

stream |> Enum.reduce
```