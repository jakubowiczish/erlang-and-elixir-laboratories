-module(pollution_server_sup).
-author("jakub").

%% API
-export([start/0]).

start() ->
  process_flag(trap_exit, true),
  Pid = spawn_link(pollution_server, init, []),
  register(server_sup, Pid),
  io:format("Starting pollution server~n"),
  receive
    {'EXIT', _, _} -> io:format("EXIT~n"), start()
  end.