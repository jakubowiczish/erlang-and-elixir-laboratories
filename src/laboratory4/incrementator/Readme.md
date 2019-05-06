### Laboratorium nr 4 - wzorce projektowe i OTP

#### Spójrz na kod i odpowiedz na następujące pytania:

Który z wzorców OTP został użyty do implementacji modułu incrementator?

Jaki rodzaj komunikacji został wykorzystany do przesyłania atomu get, a jaki do inc?

Jakie kluczowe atomy dla danego wzorca OTP zostały tutaj wykorzystane? Do czego służą?

```erlang

-module(incrementator).

-behaviour(gen_server).

%% API
-export([start_link/0, increment/1,get/1,close/1]).
-export([init/1,handle_call/3,handle_cast/2,terminate/2]).
 
%% START %%
start_link()   -> gen_server:start_link(?MODULE,0,[]).
 
%% INTERFEJS KLIENT -> SERWER %%
increment(Pid) -> gen_server:cast(Pid,inc).
get(Pid)       -> gen_server:call(Pid, get).
close(Pid)     -> gen_server:call(Pid,terminate).
init(N)        -> {ok,N}.
 
%% OBSŁUGA WIADOMOŚCI %%
handle_cast(inc, N) -> {noreply, N+1}.
 
handle_call(get,_From, N)      -> {reply, N, N};
handle_call(terminate,_From,N) -> {stop, normal, ok, N}.
 
terminate(normal, N) -> io:format("The number is: ~B~nBye.~n",[N]), ok.
````

#### Test modułu
##### W Eshellu wypróbuj następujące polecenia.

```erlang
%% Uruchomienie serwera
% Optymistyczne założenie o zwróceniu {ok, Pid}
> {ok, Pid} = incrementator:start_link().
% Odbiór liczby z serwera.
> incrementator:get(Pid).
% Zmiana liczby.
> incrementator:increment(Pid).
> incrementator:increment(Pid).
% Jaka liczba jest przetrzymywana przez serwer?
> ...
% Zakończmy działanie programu
> incrementator:close(Pid).
...
% Ponowne uruchomienie serwera.
> f(Pid).
> {ok, Pid} = incrementator:start_link().
% Przesłanie wiadomości bezpośrednio do procesu serwera
> Pid ! "czesc".
...
```

#### Poszerzenie modułu
Ostatni komunikat wynika z braku pewnej funkcji w module. Jaka to funkcja ? Poszukaj jej tu:
(http://erlang.org/doc/man/gen_server.html). Podpowiedź: ^handle.*

Założmy że użytkownik modułu incrementator chce dekrementować liczbę.

Zaimplementuj potrzebną funkcjonalność.
Przetestuj ją.