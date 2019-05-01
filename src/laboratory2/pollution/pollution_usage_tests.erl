-module(pollution_usage_tests).
-author("jakub").

%% API
-export([]).
-export([
  testWholePollutionModule/0,
  testErrorDetecting/0,
  testCreateMonitorMethod/0,
  testAddStationMethod/0,
  testAddValueMethod/0,
  testRemoveValueMethod/0,
  testGetOneValueMethod/0,
  testGetStationMeanMethod/0,
  testGetDailyMeanMethod/0,
  testImportFromCsvMethod/0,
  runAllTestingMethods/0
]).


runAllTestingMethods() ->
  testCreateMonitorMethod(),
  testAddStationMethod(),
  testAddValueMethod(),
  testRemoveValueMethod(),
  testGetOneValueMethod(),
  testGetStationMeanMethod(),
  testGetDailyMeanMethod(),
  testImportFromCsvMethod().



testCreateMonitorMethod() ->
  io:format("TESTING CREATE MONITOR METHOD:~n"),
  EmptyMonitor = pollution:createMonitor(),
  io:format("Created monitor: ~p~n", [EmptyMonitor]).



testAddStationMethod() ->
  io:format("TESTING ADD STATION METHOD:~n"),
  EmptyMonitor = pollution:createMonitor(),
  io:format("Created monitor: ~p~n", [EmptyMonitor]),

  io:format("Adding new station: Broadway, {100, 200} to this empty monitor~n"),
  BroadwayMonitor = pollution:addStation("Broadway", {100, 200}, EmptyMonitor),
  io:format("Actual state of monitor: ~p~n~n", [BroadwayMonitor]),

  %% ERROR REPORT EXPECTED
  io:format("Adding station WITH THE SAME NAME AS ONE OF EXISTING STATIONS:
  Broadway, {101, 201}~n"),
  BroadwayMonitor2 = pollution:addStation("Broadway", {101, 201}, BroadwayMonitor),
  io:format("Actual state of monitor: ~p~n~n", [BroadwayMonitor2]),

  %% ERROR REPORT EXPECTED
  io:format("Adding station WITH THE SAME COORDINATES AS ONE OF EXISTING STATIONS:
  LosAngeles, {100, 200}~n"),
  LosAngelesMonitor = pollution:addStation("LosAngeles", {100, 200}, BroadwayMonitor2),
  io:format("Actual state of monitor: ~p~n~n", [LosAngelesMonitor]).



testAddValueMethod() ->
  io:format("TESTING ADD VALUE METHOD:~n"),
  EmptyMonitor = pollution:createMonitor(),
  io:format("Created monitor: ~p~n", [EmptyMonitor]),

  io:format("Adding new station: Broadway, {100, 200} to this empty monitor~n"),
  BroadwayMonitor = pollution:addStation("Broadway", {100, 200}, EmptyMonitor),
  io:format("Actual state of monitor: ~p~n~n", [BroadwayMonitor]),

  io:format("Adding new value for station: Broadway, {100, 200} ~n"),
  ValueMonitor1 = pollution:addValue("Broadway", "7-04-2019", "PM10", 16, BroadwayMonitor),
  io:format("Actual state of monitor: ~p~n~n", [ValueMonitor1]),

  io:format("Adding new value for station: Broadway, {100, 200} ~n"),
  ValueMonitor2 = pollution:addValue({100, 200}, "7-04-2019", "PM10", 32, ValueMonitor1),
  io:format("Actual state of monitor: ~p~n~n", [ValueMonitor2]),

  %% ERROR REPORT EXPECTED
  io:format("Adding new value for station: Broadway, {100, 200} ~n"),
  ValueMonitor3 = pollution:addValue({100, 200}, "7-04-2019", "PM10", 32, ValueMonitor2),
  io:format("Actual state of monitor: ~p~n~n", [ValueMonitor3]).



testRemoveValueMethod() ->
  io:format("TESTING REMOVE VALUE METHOD:~n"),
  EmptyMonitor = pollution:createMonitor(),
  io:format("Created monitor: ~p~n", [EmptyMonitor]),

  io:format("Adding new station: Broadway, {100, 200} to this empty monitor~n"),
  BroadwayMonitor = pollution:addStation("Broadway", {100, 200}, EmptyMonitor),
  io:format("Actual state of monitor: ~p~n~n", [BroadwayMonitor]),

  io:format("Adding new value for station: Broadway, {100, 200} ~n"),
  ValueMonitor1 = pollution:addValue("Broadway", "7-04-2019", "PM10", 16, BroadwayMonitor),
  io:format("Actual state of monitor: ~p~n~n", [ValueMonitor1]),

  io:format("Removing value from station: Broadway, {100, 200}, 7-04-2019, PM10 ~n"),
  RemoveValueMonitor1 = pollution:removeValue("Broadway", "7-04-2019", "PM10", ValueMonitor1),
  io:format("Actual state of monitor: ~p~n~n", [RemoveValueMonitor1]),

  %% ERROR REPORT EXPECTED
  io:format("Removing value from station: Broadway, {100, 200}, 7-04-2019, PM2.5 ~n"),
  RemoveValueMonitor2 = pollution:removeValue("Broadway", "7-04-2019", "PM2.5", RemoveValueMonitor1),
  io:format("Actual state of monitor: ~p~n~n", [RemoveValueMonitor2]).



testGetOneValueMethod() ->
  io:format("TESTING GET ONE VALUE METHOD:~n"),
  EmptyMonitor = pollution:createMonitor(),
  io:format("Created monitor: ~p~n", [EmptyMonitor]),

  io:format("Adding new station: Broadway, {100, 200} to this empty monitor~n"),
  BroadwayMonitor = pollution:addStation("Broadway", {100, 200}, EmptyMonitor),
  io:format("Actual state of monitor: ~p~n~n", [BroadwayMonitor]),

  io:format("Adding new value for station: Broadway, {100, 200} ~n"),
  ValueMonitor1 = pollution:addValue("Broadway", "7-04-2019", "PM10", 16, BroadwayMonitor),
  io:format("Actual state of monitor: ~p~n~n", [ValueMonitor1]),

  io:format("Getting one value from station: Broadway, {100, 200} - date: 7-04-2019, type: PM10 ~n"),
  ValueFromMonitor1 = pollution:getOneValue("Broadway", "7-04-2019", "PM10", ValueMonitor1),
  io:format("Value from monitor: ~p~n~n", [ValueFromMonitor1]),

  %% ERROR REPORT EXPECTED - WRONG DATE
  io:format("Getting one value from station: Broadway, {100, 200} - date: 20-04-2019, type: PM10 ~n"),
  ValueFromMonitor2 = pollution:getOneValue("Broadway", "20-04-2019", "PM10", ValueMonitor1),
  io:format("Value from monitor: ~p~n~n", [ValueFromMonitor2]).



testGetStationMeanMethod() ->
  io:format("TESTING GET STATION MEAN METHOD:~n"),
  EmptyMonitor = pollution:createMonitor(),
  io:format("Created monitor: ~p~n", [EmptyMonitor]),

  io:format("Adding new station: Broadway, {100, 200} to this empty monitor~n"),
  BroadwayMonitor = pollution:addStation("Broadway", {100, 200}, EmptyMonitor),
  io:format("Actual state of monitor: ~p~n~n", [BroadwayMonitor]),

  io:format("Adding new value for station: Broadway, {100, 200} - value: 16, type: PM10 ~n"),
  ValueMonitor1 = pollution:addValue("Broadway", "7-04-2019", "PM10", 16, BroadwayMonitor),
  io:format("Actual state of monitor: ~p~n~n", [ValueMonitor1]),

  io:format("Adding new value for station: Broadway, {100, 200} - value: 32, type: PM10 ~n"),
  ValueMonitor2 = pollution:addValue({100, 200}, "7-04-2019", "PM10", 32, ValueMonitor1),
  io:format("Actual state of monitor: ~p~n~n", [ValueMonitor2]),

  io:format("Adding new value for station: Broadway, {100, 200} - value: 48, type: S02 ~n"),
  ValueMonitor3 = pollution:addValue({100, 200}, "7-04-2019", "S02", 48, ValueMonitor2),
  io:format("Actual state of monitor: ~p~n~n", [ValueMonitor3]),

  io:format("Getting station mean for station: Broadway, {100, 200}, for type: PM10 ~n"),
  StationMean1 = pollution:getStationMean("Broadway", "PM10", ValueMonitor3),
  io:format("Mean value of PM10 for station: Broadway, {100, 200}: ~p~n~n", [StationMean1]).



testGetDailyMeanMethod() ->
  io:format("TESTING GET DAILY MEAN METHOD:~n"),
  EmptyMonitor = pollution:createMonitor(),
  io:format("Created monitor: ~p~n", [EmptyMonitor]),

  io:format("Adding new station: Broadway, {100, 200} to this empty monitor~n"),
  BroadwayMonitor = pollution:addStation("Broadway", {100, 200}, EmptyMonitor),
  io:format("Actual state of monitor: ~p~n~n", [BroadwayMonitor]),

  io:format("Adding new value for station: Broadway, {100, 200} - value: 16, type: PM10 ~n"),
  ValueMonitor1 = pollution:addValue("Broadway", "7-04-2019", "PM10", 16, BroadwayMonitor),
  io:format("Actual state of monitor: ~p~n~n", [ValueMonitor1]),

  io:format("Adding new value for station: Broadway, {100, 200} - value: 32, type: PM10 ~n"),
  ValueMonitor2 = pollution:addValue({100, 200}, "8-04-2019", "PM10", 32, ValueMonitor1),
  io:format("Actual state of monitor: ~p~n~n", [ValueMonitor2]),

  io:format("Adding new value for station: Broadway, {100, 200} - value: 58, type: PM10 ~n"),
  ValueMonitor3 = pollution:addValue({100, 200}, "8-04-2019", "PM10", 58, ValueMonitor2),
  io:format("Actual state of monitor: ~p~n~n", [ValueMonitor3]),

  io:format("Getting station mean for station: Broadway, {100, 200}, for type: PM10, for day: 8-04-2019  ~n"),
  DailyMean1 = pollution:getDailyMean("8-04-2019", "PM10", ValueMonitor3),
  io:format("Daily mean value of PM10 for station: Broadway, {100, 200} for 8-04-2019: ~p~n~n", [DailyMean1]).



testImportFromCsvMethod() ->
  io:format("TESTING IMPORT FROM CSV METHOD:~n"),
  EmptyMonitor = pollution:createMonitor(),
  io:format("Created monitor: ~p~n", [EmptyMonitor]),

  io:format("Importing data from csv file (addStation):~n"),
  FileName = "/home/jakub/IdeaProjects/ErlangLaboratories/src/laboratory2/pollution/data.csv",
  CsvMonitor = pollution:importFromCsv(FileName, EmptyMonitor),
  io:format("Actual state of monitor: ~p~n~n", [CsvMonitor]).



testWholePollutionModule() ->
  io:format("Creating empty monitor:~n"),
  Monitor = pollution:createMonitor(),
  io:format("Created monitor: ~p~n", [Monitor]),

  io:format("Adding new station: Broadway, {100, 200} to this empty monitor~n"),
  Monitor1 = pollution:addStation("Broadway", {100, 200}, Monitor),
  io:format("Actual state of monitor: ~p~n~n", [Monitor1]),

  io:format("Adding new station: Carpentersville, {50, 51} ~n"),
  Monitor2 = pollution:addStation("Carpentersville", {50, 51}, Monitor1),
  io:format("Actual state of monitor: ~p~n~n", [Monitor2]),

  io:format("Adding new station: WallStreet, {100,121} ~n"),
  Monitor3 = pollution:addStation("WallStreet", {100, 121}, Monitor2),
  io:format("Actual state of monitor: ~p~n~n", [Monitor3]),

  io:format("Adding new value for Broadway: 4-03-2019, PM2.5, 20, ~n"),
  Monitor4 = pollution:addValue("Broadway", "4-03-2019", "PM2.5", 20, Monitor3),
  io:format("Actual state of monitor: ~p~n~n", [Monitor4]),

  io:format("Adding new value for Carpentersville: 5-03-2019, SO2, 40, ~n"),
  Monitor5 = pollution:addValue("Carpentersville", "5-03-2019", "SO2", 40, Monitor4),
  io:format("Actual state of monitor: ~p~n~n", [Monitor5]),

  io:format("Removing value from Carpentersville 5-03-2019, S02~n"),
  Monitor6 = pollution:removeValue("Carpentersville", "5-03-2019", "SO2", Monitor5),
  io:format("Actual state of monitor: ~p~n~n", [Monitor6]),

  io:format("Adding new value for Carpentersville: 5-03-2019, SO2, 40, ~n"),
  Monitor7 = pollution:addValue("Carpentersville", "5-03-2019", "SO2", 40, Monitor6),
  io:format("Actual state of monitor: ~p~n~n", [Monitor7]),

  io:format("Adding new value for Carpentersville: 6-03-2019, SO2, 60, ~n"),
  Monitor8 = pollution:addValue("Carpentersville", "6-03-2019", "SO2", 60, Monitor7),
  io:format("Actual state of monitor: ~p~n~n", [Monitor8]),

  io:format("Getting average value of SO2 for Carpentersville:~n"),
  Mean1 = pollution:getStationMean("Carpentersville", "SO2", Monitor8),
  io:format("Average value for SO2, Carpentersville ~p~n~n", [Mean1]),

  io:format("Adding new value for WallStreet: 5-03-2019, SO2, 16, ~n"),
  Monitor9 = pollution:addValue("WallStreet", "5-03-2019", "SO2", 16, Monitor8),
  io:format("Actual state of monitor: ~p~n~n", [Monitor9]),

  io:format("Getting AVERAGE VALUE of SO2 for all stations for 5-03-2019 ~n"),
  DailyMean1 = pollution:getDailyMean("5-03-2019", "SO2", Monitor9),
  io:format("DAILY AVERAGE VALUE for SO2 on 5-03-2019: ~p~n~n", [DailyMean1]),

  io:format("Getting some data from csv file:~n"),
  Monitor10 = pollution:importFromCsv("/home/jakub/IdeaProjects/ErlangLaboratories/src/laboratory2/pollution/data.csv", Monitor9),
  io:format("Actual state of monitor after parsing from csv file: ~p~n", [Monitor10]).



testErrorDetecting() ->
  io:format("Creating empty monitor:~n"),
  Monitor = pollution:createMonitor(),
  io:format("Created monitor: ~p~n", [Monitor]),

  io:format("Adding new station: Krasinskiego, {100, 200} to this empty monitor~n"),
  Monitor2 = pollution:addStation("Krasinskiego", {100, 200}, Monitor),
  io:format("Actual state of monitor: ~p~n", [Monitor2]),

  Monitor3 = pollution:addStation("Kosciuszki", {300, 500}, Monitor2),
  io:format("Actual state of monitor: ~p~n", [Monitor3]),

  io:format("Trying to ADD STATION WITH THE SAME NAME as one of existing stations:~n"),
  Monitor4 = pollution:addStation("Krasinskiego", {200, 400}, Monitor2),
  io:format("Actual state of monitor: ~p~n", [Monitor4]),

  io:format("Trying to ADD STATION WITH THE SAME COORDINATES as one of existing stations:~n"),
  Monitor5 = pollution:addStation("Krasinskiego", {300, 500}, Monitor3),
  io:format("Actual state of monitor: ~p~n", [Monitor5]),

  io:format("Trying to ADD EMPTY STATION:~n"),
  Monitor6 = pollution:addStation([], [], []),

  io:format("Adding new station: Chicago, {100,200} ~n"),
  Monitor7 = pollution:addStation("Chicago", {100, 200}, Monitor6),
  io:format("Actual state of monitor: ~p~n~n", [Monitor7]).

