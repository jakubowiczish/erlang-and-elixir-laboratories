-module(pollution_gen_server_EUnit_tests).
-author("jakub").

%% API
-include_lib("eunit/include/eunit.hrl").


-export([
  testAddStationGenServerMethod/0,
  testAddValueGenServerMethod/0,
  testRemoveValueGenServerMethod/0,
  testGetOneValueGenServerMethod/0,
  testGetStationMeanGenServerMethod/0,
  testGetDailyMeanGenServerMethod/0,
  testImportFromCsvGenServerMethod/0
]).


testAddStationGenServerMethod() ->
  pollution_server_supervisor:start(),

  ActualResult = pollution_gen_server:addStation("Broadway", {100, 200}),

  ExpectedResult = {monitor, #{{100, 200} =>{station, "Broadway", {100, 200}},
    "Broadway" =>{station, "Broadway", {100, 200}}}, #{}},

  ?assertEqual(ExpectedResult, ActualResult),

  pollution_gen_server:stop().


testAddValueGenServerMethod() ->
  pollution_server_supervisor:start(),

  pollution_gen_server:addStation("Broadway", {100, 200}),

  ActualResult = pollution_gen_server:addValue("Broadway", "7-04-2019", "PM10", 16),

  ExpectedResult = {monitor, #{{100, 200} => {station, "Broadway", {100, 200}},
    "Broadway" => {station, "Broadway", {100, 200}}},
    #{{station, "Broadway", {100, 200}} =>
    [{measurement, "7-04-2019", "PM10", 16}]}},

  ?assertEqual(ExpectedResult, ActualResult),

  pollution_gen_server:stop().


testRemoveValueGenServerMethod() ->
  pollution_server_supervisor:start(),

  pollution_gen_server:addStation("Broadway", {100, 200}),

  ActualResult = pollution_gen_server:addValue("Broadway", "7-04-2019", "PM10", 16),

  ExpectedResult = {monitor, #{{100, 200} => {station, "Broadway", {100, 200}},
    "Broadway" => {station, "Broadway", {100, 200}}},
    #{{station, "Broadway", {100, 200}} =>[{measurement, "7-04-2019", "PM10", 16}]}},

  ?assertEqual(ExpectedResult, ActualResult),

  ActualResult2 = pollution_gen_server:removeValue("Broadway", "7-04-2019", "PM10"),

  ExpectedResult2 = {monitor, #{{100, 200} =>{station, "Broadway", {100, 200}},
    "Broadway" =>{station, "Broadway", {100, 200}}},
    #{{station, "Broadway", {100, 200}} => []}},

  ?assertEqual(ExpectedResult2, ActualResult2),

  pollution_gen_server:stop().


testGetOneValueGenServerMethod() ->
  pollution_server_supervisor:start(),

  pollution_gen_server:addStation("Broadway", {100, 200}),

  pollution_gen_server:addValue("Broadway", "7-04-2019", "PM10", 16),

  ActualResult = pollution_gen_server:getOneValue("Broadway", "7-04-2019", "PM10"),

  ?assertEqual(16, ActualResult),

  pollution_gen_server:stop().


testGetStationMeanGenServerMethod() ->
  pollution_server_supervisor:start(),

  pollution_gen_server:addStation("Broadway", {100, 200}),

  pollution_gen_server:addValue("Broadway", "7-04-2019", "PM10", 16),

  pollution_gen_server:addValue("Broadway", "7-04-2019", "PM10", 48),

  ActualResult = pollution_gen_server:getStationMean("Broadway", "PM10"),

  ?assertEqual(32.0, ActualResult),

  pollution_gen_server:stop().


testGetDailyMeanGenServerMethod() ->
  pollution_server_supervisor:start(),

  pollution_gen_server:addStation("Broadway", {100, 200}),

  pollution_gen_server:addValue("Broadway", "8-04-2019", "PM10", 16),

  pollution_gen_server:addValue("Broadway", "8-04-2019", "PM10", 48),

  ActualResult = pollution_gen_server:getDailyMean("8-04-2019", "PM10"),

  ?assertEqual(32.0, ActualResult),

  pollution_gen_server:stop().


testImportFromCsvGenServerMethod() ->
  pollution_server_supervisor:start(),

  ActualResult = pollution_gen_server:importFromCsv("/home/jakub/IdeaProjects/ErlangLaboratories/src/laboratory4/pollution_gen_server/data.csv"),

  ExpectedResult = {monitor,
    #{{365, 366} => {station, "NewYork", {365, 366}},
      "NewYork" => {station, "NewYork", {365, 366}}},
    #{{station, "NewYork", {365, 366}} =>
    [{measurement, "6-03-2019", "PM10", 20}]}},

  ?assertEqual(ExpectedResult, ActualResult),

  pollution_gen_server:stop().
