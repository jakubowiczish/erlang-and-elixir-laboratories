-module(pollution_server_supervisor).
-author("jakub").

-behavior(supervisor).

%% API

-export([start_link/1, init/1]).




start_link(InitMonitor) ->
  supervisor:start_link({local, pollution_gen_server_supervisor}, ?MODULE, InitMonitor).


init(InitMonitor) ->
  {ok, {
    {one_for_one, 2, 3},
    [{pollution_gen_server,
      {pollution_gen_server, start_link, [InitMonitor]},
      permanent, brutal_kill, worker, [pollution_gen_server]}
    ]}
  }.





