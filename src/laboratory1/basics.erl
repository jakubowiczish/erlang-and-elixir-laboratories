-module(basics).
-author("jakub").

-export([factorial/1]).
-export([sumToN/1]).
-export([power/2]).

factorial(N) ->
  case N of
    0 -> 1;
    _ -> N * factorial(N - 1)
  end.

sumToN(N) ->
  case N of
    0 -> 0;
    1 -> 1;
    _ -> N + sumToN(N - 1)
  end.

power(X, N) ->
  case N of
    0 -> 1;
    1 -> X;
    _ -> X * power(X, N - 1)
  end.

