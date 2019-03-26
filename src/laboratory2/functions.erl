-module(functions).
-author("jakub").

%% API
-export([]).
-export([map/2]).

%% ExemplaryFun = fun(X) -> 2 * X end.

map(Fun, List) ->
  [Fun(X) || X <- List].

%%sum_of_digits(Number) ->
