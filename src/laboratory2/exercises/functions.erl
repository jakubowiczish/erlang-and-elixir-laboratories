-module(functions).
-author("jakub").

%% API
-export([]).
-export([map/2, spawnProcess/0, exemplaryFun/0]).


exemplaryFun() ->
  fun(X) -> 2 * X end.


map(Fun, List) ->
  [Fun(X) || X <- List].


spawnProcess() ->
  spawn(
    fun() ->
      receive
        _ -> io:format("Message received!~n")
      end
    end).