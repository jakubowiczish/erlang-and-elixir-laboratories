-module(pollution_server_supervisor_test).
-author("jakub").

%% API
-export([testPollutionGenServerSupervisor/0]).


testPollutionGenServerSupervisor() ->
  M = pollution_server_supervisor:start_link(pollution:createMonitor()),

  pollution_gen_server:start(M).