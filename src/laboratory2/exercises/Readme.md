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
