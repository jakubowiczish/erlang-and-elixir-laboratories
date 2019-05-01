-module(pollution_EUnit_tests).
-author("jakub").

%% API
-include_lib("eunit/include/eunit.hrl").

-export([
  testCreateMonitorMethod/0,
  testAddStationMethod/0,
  runAllTests/0
  , testAddValueMethod/0]).


runAllTests() ->
  testCreateMonitorMethod(),
  testAddStationMethod(),
  testAddValueMethod().

testCreateMonitorMethod() ->
  EmptyMonitor = pollution:createMonitor(),

  ?assertNotEqual({monitore, #{}, #{}}, EmptyMonitor),

  ?assertEqual({monitor, #{}, #{}}, EmptyMonitor).



testAddStationMethod() ->
  EmptyMonitor = pollution:createMonitor(),
  ActualStation = pollution:addStation("Broadway", {100, 200}, EmptyMonitor),

  ExpectedStation = {monitor, #{{100, 200} =>{station, "Broadway", {100, 200}},
    "Broadway" =>{station, "Broadway", {100, 200}}}, #{}},

  ?assertEqual(
    ExpectedStation,
    ActualStation
  ).



testAddValueMethod() ->
  EmptyMonitor = pollution:createMonitor(),
  BroadwayMonitor = pollution:addStation("Broadway", {100, 200}, EmptyMonitor),
  ValueMonitor = pollution:addValue("Broadway", "7-04-2019", "PM10", 16, BroadwayMonitor),

  ?assertEqual(
    {monitor,
    #{{100, 200} => {station, "Broadway", {100, 200}},
      "Broadway" => {station, "Broadway", {100, 200}}},
      #{{station, "Broadway", {100, 200}} =>[{measurement, "7-04-2019", "PM10", 16}]}},

    ValueMonitor
  ).


