-module(pingpong).
-author("jakub").

%% API
-export([start/0, initialize/0]).


start() ->
  case (lists:member(ping, registered())) or (lists:member(pong, registered())) of
    true -> error_logger:error_msg("The process is ALREADY RUNNING");
    false ->
      PingPid = spawn(fun() -> initialize() end),
      PongPid = spawn(fun() -> initialize() end),
      register(ping, PingPid),
      register(pong, PongPid),
      ping ! pong,
      pong ! ping
  end.


initialize() ->
  receive
    To -> loop(To)
  after 20000 ->
    io:format("TIMEOUT ~n"),
    timeout
  end.


loop(Pid) ->
  receive
    {From, N} when N > 0 ->
      Who = case Pid of
              ping -> "Ping";
              pong -> "Pong"
            end,
      io:format("~s is now equal to: ~B~n from: ~p ~n", [Who, N, From]),
      Pid ! {self(), N - 1},
      loop(Pid);
    {From, terminate} ->
      io:format("Received TERMINATION signal from: ~p~n", [From]),
      ok
  after 10000 ->
    io:format("TIMEOUT ~n"),
    timeout
  end.
