-module(pollutionTest).
-author("jakub").

%% API
-export([]).
-export([test_pollution_module/0, test_errors_detecting/0]).


test_pollution_module() ->
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

  io:format("Getting average value of SO2 for all stations for 5-03-2019 ~n"),
  DailyMean1 = pollution:getDailyMean("5-03-2019", "SO2", Monitor9),
  io:format("Daily average value for SO2 on 5-03-2019: ~p~n~n", [DailyMean1]),

  io:format("Getting some data from csv file:~n"),
  Monitor10 = pollution:importFromCsv("/home/jakub/IdeaProjects/ErlangLaboratories/src/laboratory3/airpollution/data.csv", Monitor9),
  io:format("Actual state of monitor after parsing from csv file: ~p~n", [Monitor10]).



test_errors_detecting() ->
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

