# Laboratorium nr 3 - programowanie procesów w Erlangu

## Rozgrzewka

```erlang
%%Tworzenie procesów.
>
> spawn(fun() -> io:format("To jest tekst~n") end).
>
> F = ... %definicja Twojego funa!
> spawn(F).
%% Przesyłanie wiadomości
> Proces1 = spawn(fun() -> 
>   receive 
>     _ -> io:format("Otrzymalem wiadomosc!~n") 
>   end 
> end).
> Proces1 ! ... % wyślij jakąś wiadomość
> Proces1 ! ... % jeszcze raz
% Co się stało ? I dlaczego ?
...
%% Teraz stworzymy proces który przetrzymuje jakiś stan.
%% By to zrobić, wpierw musimy zdefinować funkcjonalność procesu.
% Funkcjonalność procesu
> IncLoop = fun Loop(N) ->
>   receive
>     inc   -> Loop(N+1);
>     print -> io:format("~B~n",[N]), Loop(N);
>     stop  -> ok
>   end
> end.
>
%% Tworzenie procesu
%% Zwróć uwagę na funa... 
> Proces2 = spawn(fun() -> IncLoop(0) end).
%% Czy poniższa linijka zadziała ?
> Proces3 = spawn(IncLoop).
% Dlaczego ?
...
%% Co robi ta linijka ?
> register(proces_stanu, Proces2).
%% Teraz mamy bardziej skomplikowany proces, który zarządza jakimś stanem
%% Co jest tym stanem ?
...
%% Co możemy robić z tym stanem ?
...
%% Komunikacja z procesem stanu.
> Proces2 ! inc.
> proces_stanu ! print.
> proces_stanu ! inc.
> Proces2 ! print.
```

## Ping - Pong
- Napisz moduł pingpong, który będzie eksportował funkcje:
  - start/0, która utworzy 2 procesy i zarejestruje je pod nazwami ping i pong,
  - stop/0, która zakończy oba procesy,
  - play/1, która wyśle wiadomość z liczbą całkowitą N do procesu ping.

- Po otrzymaniu wiadomości, proces ping ma rozpocząć wymianę N wiadomości z procesem pong. 
- Przy odebraniu każdej wiadomości procesy mają wypisać na standardowe wyjście informację o przebiegu odbijania.
- Dla zwiększenia czytelności działania warto użyć funkcji timer:sleep(Milisec).
- Procesy ping i pong powinny samoczynnie kończyć działanie po 20 sekundach bezczynności.

- Zmodyfikuj proces ping by przechowywał stan - sumę wszystkich liczb z komunikatów, które otrzymał. 
- Dodaj tę sumę do informacji wypisywanej po odebraniu komunikatu.

## Distributed Erlang
- W tej części trzeba będzie skorzystać z maszyn w laboratorium.

- uruchom węzeł erlanga, spróbuj połączyć się z węzłem uruchomionym przez prowadzącego
- przyda się funkcja net_adm:ping(Node) oraz BIF nodes().
- napisz… szczegóły na laboratorium.

## Serwer zanieczyszczeń
- Zaimplementuj moduł pollution_server, który będzie startował proces obsługujący funkcjonalność modułu pollution. Powinien działać analogicznie do serwera zmiennej globalnej - o bogatszej funkcjonalności.
- Dodatkowe funkcje eksportowane: start/0 i stop/0.
- Dodatkowa funkcja prywatna: init/0, która będzie wykonywana już w kontekście nowego procesu
- Serwer powinien dostarczyć funkcje analogiczne do modułu pollution - ale każda z nich będzie miała o jeden argument mniej.

## Zadanie domowe
- Dokończ moduł pollution_server
- Napisz testy modułu pollution i pollution_server.
