-module(pollutionTest).
-author("jakub").

%% API
-export([]).
-export([test_pollution_module/0]).

test_pollution_module() ->
  io:format("Creating empty monitor:~n"),
  Monitor = pollution:createMonitor(),
  io:format("Monitor: ~p~n", [Monitor]),
  io:format("Adding new station: Krasinskiego, {100, 200} to this empty monitor~n"),
  pollution:addStation("Krasinskiego", {100, 200}, Monitor).