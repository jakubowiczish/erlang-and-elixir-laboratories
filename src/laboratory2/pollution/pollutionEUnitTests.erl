-module(pollutionEUnitTests).
-author("jakub").

%% API
-include_lib("eunit/include/eunit.hrl").

-export([
  testCreateMonitorMethod/0,
  testAddStationMethod/0
]).



testCreateMonitorMethod() ->
  EmptyMonitor = pollution:createMonitor(),
  ?assertNotEqual({monitore, #{}, #{}}, EmptyMonitor),
  ?assertEqual({monitor, #{}, #{}}, EmptyMonitor).



testAddStationMethod() ->
  EmptyMonitor = pollution:createMonitor(),
  BroadwayMonitor = pollution:addStation("Broadway", {100, 200}, EmptyMonitor),

  ?assertEqual(
    {monitor, #{{100, 200} =>{station, "Broadway", {100, 200}},
      "Broadway" =>
      {station, "Broadway", {100, 200}}},
      #{}},
    BroadwayMonitor
  ).



testAddValueMethod() ->
  EmptyMonitor = pollution:createMonitor(),
  BroadwayMonitor = pollution:addStation("Broadway", {100, 200}, EmptyMonitor),
  ValueMonitor1 = pollution:addValue("Broadway", "7-04-2019", "PM10", 16, BroadwayMonitor).




