-module(pollution_EUnit_tests).
-author("jakub").

%% API
-include_lib("eunit/include/eunit.hrl").

-export([
  runAllTests/0,
  testCreateMonitorMethod/0,
  testAddStationMethod/0,
  testAddValueMethod/0,
  testRemoveValueMethod/0,
  testGetOneValueMethod/0,
  testGetStationMeanMethod/0,
  testGetDailyMeanMethod/0, testImportFromCsvMethod/0]).


runAllTests() ->
  testCreateMonitorMethod(),
  testAddStationMethod(),
  testAddValueMethod(),
  testRemoveValueMethod(),
  testGetOneValueMethod(),
  testGetStationMeanMethod(),
  testGetDailyMeanMethod(),
  testImportFromCsvMethod().




testCreateMonitorMethod() ->
  EmptyMonitor = pollution:createMonitor(),

  ?assertNotEqual({monitore, #{}, #{}}, EmptyMonitor),

  ?assertEqual({monitor, #{}, #{}}, EmptyMonitor).



testAddStationMethod() ->
  EmptyMonitor = pollution:createMonitor(),

  ActualMonitor = pollution:addStation("Broadway", {100, 200}, EmptyMonitor),
  ExpectedMonitor = {monitor, #{{100, 200} =>{station, "Broadway", {100, 200}},
    "Broadway" =>{station, "Broadway", {100, 200}}}, #{}},

  ?assertEqual(ExpectedMonitor, ActualMonitor).



testAddValueMethod() ->
  EmptyMonitor = pollution:createMonitor(),
  BroadwayMonitor = pollution:addStation("Broadway", {100, 200}, EmptyMonitor),

  ActualMonitor = pollution:addValue("Broadway", "7-04-2019", "PM10", 16, BroadwayMonitor),
  ExpectedMonitor = {monitor, #{{100, 200} => {station, "Broadway", {100, 200}},
    "Broadway" => {station, "Broadway", {100, 200}}},
    #{{station, "Broadway", {100, 200}} =>[{measurement, "7-04-2019", "PM10", 16}]}},

  ?assertEqual(ExpectedMonitor, ActualMonitor).



testRemoveValueMethod() ->
  EmptyMonitor = pollution:createMonitor(),
  BroadwayMonitor = pollution:addStation("Broadway", {100, 200}, EmptyMonitor),

  MonitorWithValue = pollution:addValue("Broadway", "7-04-2019", "PM10", 16, BroadwayMonitor),

  ActualMonitor = pollution:removeValue("Broadway", "7-04-2019", "PM10", MonitorWithValue),
  ExpectedMonitor = {monitor, #{{100, 200} => {station, "Broadway", {100, 200}},
    "Broadway" =>{station, "Broadway", {100, 200}}},
    #{{station, "Broadway", {100, 200}} => []}},

  ?assertEqual(ExpectedMonitor, ActualMonitor).



testGetOneValueMethod() ->
  EmptyMonitor = pollution:createMonitor(),
  BroadwayMonitor = pollution:addStation("Broadway", {100, 200}, EmptyMonitor),

  MonitorWithValue = pollution:addValue("Broadway", "7-04-2019", "PM10", 16, BroadwayMonitor),
  ActualValue = pollution:getOneValue("Broadway", "7-04-2019", "PM10", MonitorWithValue),

  ?assertEqual(16, ActualValue).



testGetStationMeanMethod() ->
  EmptyMonitor = pollution:createMonitor(),
  BroadwayMonitor = pollution:addStation("Broadway", {100, 200}, EmptyMonitor),
  ChicagoMonitor = pollution:addStation("Chicago", {101, 201}, BroadwayMonitor),

  MonitorWithValue = pollution:addValue("Broadway", "7-04-2019", "PM10", 16, ChicagoMonitor),
  MonitorWithValue2 = pollution:addValue("Broadway", "8-04-2019", "PM10", 32, MonitorWithValue),
  MonitorWithValue3 = pollution:addValue("Chicago", "8-04-2019", "PM10", 96, MonitorWithValue2),

  ActualValue = pollution:getStationMean("Broadway", "PM10", MonitorWithValue3),

  ?assertEqual(24.0, ActualValue).



testGetDailyMeanMethod() ->
  EmptyMonitor = pollution:createMonitor(),
  BroadwayMonitor = pollution:addStation("Broadway", {100, 200}, EmptyMonitor),
  ChicagoMonitor = pollution:addStation("Chicago", {101, 201}, BroadwayMonitor),

  MonitorWithValue = pollution:addValue("Broadway", "7-04-2019", "PM10", 16, ChicagoMonitor),
  MonitorWithValue2 = pollution:addValue("Broadway", "8-04-2019", "PM10", 32, MonitorWithValue),
  MonitorWithValue3 = pollution:addValue("Chicago", "8-04-2019", "PM10", 96, MonitorWithValue2),

  ActualValue = pollution:getDailyMean("8-04-2019", "PM10", MonitorWithValue3),

  ?assertEqual(64.0, ActualValue).



testImportFromCsvMethod() ->
  EmptyMonitor = pollution:createMonitor(),
  FileName = "/home/jakub/IdeaProjects/ErlangLaboratories/src/laboratory2/pollution/data.csv",
  CsvMonitor = pollution:importFromCsv(FileName, EmptyMonitor),

  ExpectedMonitor = {monitor, #{{365, 366} => {station, "NewYork", {365, 366}},
    "NewYork" => {station, "NewYork", {365, 366}}},
    #{{station, "NewYork", {365, 366}} =>[{measurement, "6-03-2019", "PM10", 20}]}},

  ?assertEqual(ExpectedMonitor, CsvMonitor).

