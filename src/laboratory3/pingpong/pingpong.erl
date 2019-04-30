-module(pingpong).
-author("jakub").


%% API
-export([start/0, stop/0, play/1]).

%% pingpong:start().
%% pingpong:play(10).
%% pingpong:stop().


start() ->
  case (lists:member(ping, registered())) or (lists:member(pong, registered())) of
    true -> error_logger:error_msg("The process is ALREADY RUNNING ~n");
    false ->
      PingPid = spawn(fun() -> init() end),
      PongPid = spawn(fun() -> init() end),
      register(ping, PingPid),
      register(pong, PongPid),
      ping ! pong,
      pong ! ping
  end.



stop() ->
  case (lists:member(ping, registered())) or (lists:member(pong, registered())) of
    false -> error_logger:error_msg("Ping pong is not running - NOTHING TO TERMINATE ~n");
    true ->
      ping ! {self(), terminate},
      pong ! {self(), terminate}
  end.



play(N) ->
  pong ! {self(), play, N}.



loop(Pid) ->
  receive
    {From, play, N} when N > 0 ->
      Who = case Pid of
              ping -> "Ping";
              pong -> "Pong"
            end,
      io:format("~s is now equal to: ~B~n from: ~p ~n", [Who, N, From]),
      Pid ! {self(), play, N - 1},
      loop(Pid);
    {From, terminate} ->
      io:format("Received TERMINATION signal from: ~p~n", [From]),
      ok
  after 20000 ->
    io:format("TIMEOUT ~n"),
    timeout
  end.



init() ->
  receive
    To -> loop(To)
  after 20000 ->
    io:format("TIMEOUT ~n"),
    timeout
  end.