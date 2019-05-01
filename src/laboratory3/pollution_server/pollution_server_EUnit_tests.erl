-module(pollution_server_EUnit_tests).
-author("jakub").

%% API
-include_lib("eunit/include/eunit.hrl").

-export([addStationMethodTest/0, addValueMethodTest/0]).


%%runAllTestsServer() ->


addStationMethodTest() ->
  pollution_server:start(),

  ActualMonitor = pollution_server:addStation("Broadway", {100, 200}),
  ?assertEqual(addStation, ActualMonitor),

  pollution_server:stop().


addValueMethodTest() ->
  pollution_server:start(),

  pollution_server:addStation("Broadway", {100, 200}),
  MonitorWithValue = pollution_server:addValue("Broadway", "7-04-2019", "PM10", 16),

  ?assertEqual(addValue, MonitorWithValue),

  pollution_server:stop().




