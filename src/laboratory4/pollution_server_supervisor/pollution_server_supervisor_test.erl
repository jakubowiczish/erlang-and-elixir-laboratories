-module(pollution_server_supervisor_test).
-author("jakub").

%% API
-export([testPollutionGenServerSupervisor/0]).


testPollutionGenServerSupervisor() ->
  pollution_server_supervisor:start().

%%  pollution_gen_server:start(M).