-module(pollution_server_supervisor_test).
-author("jakub").

%% API
-export([testPollutionGenServerSupervisor/0]).


testPollutionGenServerSupervisor() ->
  pollution_server_supervisor:start(),

  pollution_gen_server:addStation("Broadway", {100, 200}),

  pollution_gen_server:crash(),

  timer:sleep(1000),

  pollution_gen_server:addStation("Broadway", {100, 200}),

  pollution_gen_server:stop().




