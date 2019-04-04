-module(pollutionTest).
-author("jakub").

%% API
-export([]).
-export([test_pollution_module/0, test_errors_detecting/0]).

test_pollution_module() ->
  io:format("Creating empty monitor:~n"),
  Monitor = pollution:createMonitor(),
  io:format("Created monitor: ~p~n", [Monitor]),

  io:format("Adding new station: Krasinskiego, {100, 200} to this empty monitor~n"),
  Monitor2 = pollution:addStation("Krasinskiego", {100, 200}, Monitor),
  io:format("Actual state of monitor: ~p~n", [Monitor2]),

  Monitor3 = pollution:addValue("Krasinskiego", "4-03-2019", "PM2.5", 20, Monitor2),
  io:format("Actural state of monitor: ~p~n", [Monitor3]).


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
  Monitor6 = pollution:addStation([], [], []).

