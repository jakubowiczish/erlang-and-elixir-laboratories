-module(pollution_server_EUnit_tests).
-author("jakub").

%% API
-include_lib("eunit/include/eunit.hrl").

-export([
  testAddStationServerMethod/0,
  testAddValueServerMethod/0,
  testRemoveValueServerMethod/0,
  testGetOneValueServerMethod/0,
  testGetStationMeanServerMethod/0,
  testGetDailyMeanServerMethod/0,
  testImportFromCsvServerMethod/0,
  runAllServerTestMethods/0
]).



runAllServerTestMethods() ->
  testAddStationServerMethod(),
  testAddValueServerMethod(),
  testRemoveValueServerMethod(),
  testGetOneValueServerMethod(),
  testGetStationMeanServerMethod(),
  testGetDailyMeanServerMethod(),
  testImportFromCsvServerMethod().



testAddStationServerMethod() ->
  pollution_server:start(),

  ActualMonitor = pollution_server:addStation("Broadway", {100, 200}),
  ?assertEqual(addStation, ActualMonitor),

  pollution_server:stop().



testAddValueServerMethod() ->
  pollution_server:start(),

  pollution_server:addStation("Broadway", {100, 200}),
  Monitor = pollution_server:addValue("Broadway", "7-04-2019", "PM10", 16),

  ?assertEqual(addValue, Monitor),

  pollution_server:stop().



testRemoveValueServerMethod() ->
  pollution_server:start(),

  pollution_server:addStation("Broadway", {100, 200}),
  pollution_server:addValue("Broadway", "7-04-2019", "PM10", 16),
  Monitor = pollution_server:removeValue("Broadway", "7-04-2019", "PM10"),

  ?assertEqual(removeValue, Monitor),

  pollution_server:stop().



testGetOneValueServerMethod() ->
  pollution_server:start(),

  pollution_server:addStation("Broadway", {100, 200}),
  pollution_server:addValue("Broadway", "7-04-2019", "PM10", 16),
  Monitor = pollution_server:getOneValue("Broadway", "7-04-2019", "PM10"),

  ?assertEqual(getOneValue, Monitor),

  pollution_server:stop().



testGetStationMeanServerMethod() ->
  pollution_server:start(),

  pollution_server:addStation("Broadway", {100, 200}),
  pollution_server:addValue("Broadway", "7-04-2019", "PM10", 16),
  pollution_server:addValue("Broadway", "7-04-2019", "PM10", 32),

  Monitor = pollution_server:getStationMean("Broadway", "PM10"),

  ?assertEqual(getStationMean, Monitor),

  pollution_server:stop().



testGetDailyMeanServerMethod() ->
  pollution_server:start(),

  pollution_server:addStation("Broadway", {100, 200}),
  pollution_server:addValue("Broadway", "7-04-2019", "PM10", 16),
  pollution_server:addValue("Broadway", "7-04-2019", "PM10", 32),

  Monitor = pollution_server:getDailyMean("7-04-2019", "PM10"),

  ?assertEqual(getDailyMean, Monitor),

  pollution_server:stop().



testImportFromCsvServerMethod() ->
  pollution_server:start(),

  FileName = "/home/jakub/IdeaProjects/ErlangLaboratories/src/laboratory2/pollution/data.csv",

  Monitor = pollution_server:importFromCsv(FileName),

  ?assertEqual(importFromCsv, Monitor),

  pollution_server:stop().










