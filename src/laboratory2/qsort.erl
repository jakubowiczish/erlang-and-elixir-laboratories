
-module(qsort).
-author("jakub").

%% API
-export([]).
-export([lessThan/2]).
-export([grtEqThan/2]).

lessThan([], _) ->
  [];
lessThan(List, Arg) ->
  [X || X <- List, X < Arg].

grtEqThan([], _) ->
  [];
grtEqThan(List, Arg) ->
  [X || X <- List, X >= Arg].