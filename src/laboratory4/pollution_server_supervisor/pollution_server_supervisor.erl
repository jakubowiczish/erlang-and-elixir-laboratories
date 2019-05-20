-module(pollution_server_supervisor).
-author("jakub").

-behavior(supervisor).

%% API

-export([
  start/0,
  start_link/1,
  init/1
]).


start() ->
  ets:new(monitor_guardian, [set, public, named_table]),
  Monitor = pollution:createMonitor(),
  ets:insert(monitor_guardian, [{last_state, Monitor}]),
  start_link(Monitor).



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
