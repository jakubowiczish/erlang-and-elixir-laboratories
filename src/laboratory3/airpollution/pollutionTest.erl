-module(pollutionTest).
-author("jakub").

%% API
-export([]).
-export([test_pollution_module/0]).

test_pollution_module() ->
  io:format("Creating empty monitor:~n"),
  Monitor = pollution:createMonitor(),
  io:format("Created monitor: ~p~n", [Monitor]),
  io:format("Adding new station: Krasinskiego, {100, 200} to this empty monitor~n"),
  Monitor2 = pollution:addStation("Krasinskiego", {100, 200}, Monitor),
  io:format("Actual state of monitor: ~p~n", [Monitor2]),
  io:format("Trying to add station with the the same name as one of existing stations:~n"),
  Monitor3 = pollution:addStation("Krasinskiego", {200, 400}, Monitor2), % check whether error detecting works
  io:format("Actual state of monitor: ~p~n", [Monitor3]),
  io:format("Trying to add empty station:~n"),
  Monitor4 = pollution:addStation([],[],[]).
