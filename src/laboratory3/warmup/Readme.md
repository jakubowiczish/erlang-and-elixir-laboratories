### Laboratorium nr 3 - programowanie procesów w Erlangu

#### Rozgrzewka

W Eshellu

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