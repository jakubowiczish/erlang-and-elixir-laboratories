-module(basics).
-author("jakub").

%% API
-export([]).

%% LIST COMPREHENSIONS - examples for myself
%% L = lists:seq(1, 100).
%% List = [X || X <- L, X rem 2 == 0].
%% Hello = fun(X) -> io:format("Hello ~s~n", [X]) end.

%% Add1 = fun(X) -> X + 1 end.
%% lists:map(Add1, [1,2,3]).
%% lists:map(fun(X) -> X+2 end, [1,2,3]).
%% lists:map(fun math:sqrt/1, [1,2,3]).

%% Multi2 = fun(X) -> 2 * X end.
%% lists:map(Multi2, [1,2,3]).
