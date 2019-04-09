-module(warmup).
-author("jakub").

%% API
-export([]).

%%F = fun(X) -> 2 * X end.

%%Process1 = spawn(fun() ->
%%  receive
%%    _ -> io:format("I received a message:~n")
%%  end
%%end).

%%IncLoop = fun Loop(N) ->
%%  receive
%%    inc -> Loop(N + 1);
%%    print -> io:format("~B~n", [N]), Loop(N);
%%    stop -> ok
%%  end
%%end.