-module(pollution_server_supervisor).
-author("jakub").

-behavior(supervisor).

%% API

-export([start/0, init/1]).


start() ->
  ets:new(monitorKeeper, [set, public, named_table]),
  Monitor = pollution:createMonitor(),
  ets:insert(monitorKeeper, [{lastState, Monitor}]),
  supervisor:start_link({local, pollutionSupervisor}, ?MODULE, Monitor).




init(InitialMonitor) ->
  {ok,
    {{one_for_one, 3, 5},
      [{pollution_gen_server,
        {pollution_gen_server, start, [InitialMonitor]},
        permanent, brutal_kill, worker, [pollution_gen_server]}]
    }}.





