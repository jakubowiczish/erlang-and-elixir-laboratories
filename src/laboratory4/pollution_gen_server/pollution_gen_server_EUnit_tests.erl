-module(pollution_gen_server_EUnit_tests).
-author("jakub").

%% API
-include_lib("eunit/include/eunit.hrl").

-export([testAddStationGenServerMethod/0, testAddValueGenServerMethod/0]).



testAddStationGenServerMethod() ->
  pollution_gen_server:start(pollution:createMonitor()),

  ActualResult = pollution_gen_server:addStation("Broadway", {100, 200}),

  ExpectedResult = {monitor, #{{100, 200} =>{station, "Broadway", {100, 200}},
    "Broadway" =>{station, "Broadway", {100, 200}}}, #{}},

  ?assertEqual(ExpectedResult, ActualResult),

  pollution_gen_server:stop().



testAddValueGenServerMethod() ->
  pollution_gen_server:start(pollution:createMonitor()),

  pollution_gen_server:addStation("Broadway", {100, 200}),

  ActualResult = pollution_gen_server:addValue("Broadway", "7-04-2019", "PM10", 16),

  ExpectedResult = {monitor, #{{100, 200} => {station, "Broadway", {100, 200}},
    "Broadway" => {station, "Broadway", {100, 200}}},
    #{{station, "Broadway", {100, 200}} =>
    [{measurement, "7-04-2019", "PM10", 16}]}},

  ?assertEqual(ExpectedResult, ActualResult),

  pollution_gen_server:stop().



