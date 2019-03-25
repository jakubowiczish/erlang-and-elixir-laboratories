-module(basics).
-author("jakub").

%% API
-export([check_divisibility/1]).
-export([check_divisibility_using_if/1]).
-export([test_record/0]).
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

%% [{X, X * X, X * X * X} || X <- lists:seq(1,100)].

check_divisibility([]) ->
  [];
check_divisibility(X) ->
  [X || X rem 4 == 0, X rem 7 == 0].

check_divisibility_using_if([]) ->
  [];
check_divisibility_using_if(X) ->
  if
    (X rem 4 == 0) and (X rem 7 == 0) -> X;
    true -> io:format("Number is not divisible by 4 and 7\n")
  end.


-record(group, {name, amount, state = active}).
test_record() ->
  Group1 = #group{name = "Group1", amount = 5, state = inactive},
  Group2 = #group{name = "Group2", amount = 10},
  io:format(Group1#group.name).