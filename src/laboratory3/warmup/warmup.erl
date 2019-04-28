-module(warmup).
-author("jakub").

%% API
-export([f/0, process/0, loop/0]).

f() ->
  fun(X) -> 2 * X end.


process() ->
  Process1 = spawn(
    fun() ->
      receive
        _ -> io:format("I received a message:~n")
      end
    end
  ).


loop() ->
  fun Loop(N) ->
    receive
      inc -> Loop(N + 1);
      print -> io:format("~B~n", [N]), Loop(N);
      stop -> ok
    end
  end.