-module(myLists).
-author("jakub").

%% API
-export([]).
-export([contains/2]).
-export([contains_case/2]).
-export([contains_best/2]).
-export([sumFloats/1]).
-export([sumFloats_case/1]).
-export([duplicateElements/1]).
-export([duplicateElements_2/1]).
-export([sumFloatsTailRecursion/2]).

contains([], N) ->
  false;
contains([H | T], N) ->
  if
    H == N -> true;
    H =/= N -> contains(T, N)
  end.

contains_case([], N) ->
  false;
contains_case([H | T], N) ->
  case H of
    N -> true;
    _ -> contains_case(T, N)
  end.

contains_best([], _) -> false;
contains_best([H | _], H) -> true;
contains_best([_ | T], V) -> contains_best(T, V).

sumFloats([]) ->
  0;
sumFloats([H | T]) ->
  if
    is_float(H) -> H + sumFloats(T);
    true -> sumFloats(T)
  end.

sumFloats_case([]) ->
  0;
sumFloats_case([H | T]) ->
  case is_float(H) of
    true -> H + sumFloats_case(T);
    false -> sumFloats_case(T)
  end.

sumFloatsTailRecursion([], Sum) ->
  Sum;
sumFloatsTailRecursion([H | T], Sum) ->
  if
    is_float(H) -> Sum + H + sumFloatsTailRecursion(T, Sum);
    true -> sumFloatsTailRecursion(T, Sum)
  end.


duplicateElements([]) ->
  [];
duplicateElements([H | T]) ->
  [H, H] ++ duplicateElements(T).

duplicateElements_2([]) ->
  [];
duplicateElements_2([H | T]) ->
  duplicateElements_2([H, H | duplicateElements_2(T)]).

