-module(pingpong).
-author("jakub").

%% API
-export([start/0]).

start() ->
  Ping = spawn(fun() ->
    receive
      _ -> io:format("Received a message~n"),
        pong ! inc
    end
               end),

  Pong = spawn(fun() ->
    receive
      _ -> io:format("Received a message~n"),
        ping ! inc
    end
               end),

  register(ping, Ping),
  register(pong, Pong),
  ping ! inc.

