-module(qsort).
-author("jakub").

%% API
-export([]).
-export([lessThan/2]).
-export([grtEqThan/2]).
-export([qs/1]).
-export([randomElems/3]).
-export([compareSpeeds/3]).


lessThan([], _) ->
  [];
lessThan(List, Arg) ->
  [X || X <- List, X < Arg].


grtEqThan([], _) ->
  [];
grtEqThan(List, Arg) ->
  [X || X <- List, X >= Arg].


qs([]) ->
  [];
qs([Pivot | Tail]) ->
  qs(lessThan(Tail, Pivot)) ++ [Pivot] ++ qs(grtEqThan(Tail, Pivot)).


randomElems(N, Min, Max) ->
  [Min + rand:uniform(Max - Min) || X <- lists:seq(1, N)].


compareSpeeds(List, Fun1, Fun2) ->
  {Time1, _} = timer:tc(qsort, Fun1, [List]),
  {Time2, _} = timer:tc(lists, Fun2, [List]),
  io:fwrite("Time of sorting using qsort:qs: ~f seconds,~nTime of sorting using lists:sort: ~f seconds ~n", [Time1 / 1000000, Time2 / 1000000]).

