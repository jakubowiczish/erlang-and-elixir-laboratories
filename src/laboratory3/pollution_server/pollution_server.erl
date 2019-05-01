-module(pollution_server).
-author("jakub").

%% API
-export([
  start/0,
  stop/0,
  init/0
]).

-export([
  addStation/2,
  addValue/4,
  removeValue/3,
  getOneValue/3,
  getStationMean/2,
  getDailyMean/2,
  importFromCsv/1
]).


start() ->
  io:format("Starting server~n"),
  register(pollutionServer, spawn(pollution_server, init, [])).



init() ->
  Monitor = pollution:createMonitor(),
  loop(Monitor).



stop() ->
  pollutionServer ! {request, self(), stop},
  receive
    {reply, Reply} -> Reply
  end.



loop(Monitor) ->
  receive
    {request, Pid, addStation, {Name, {Latitude, Longitude}}} ->
      ResultMonitor = pollution:addStation(Name, {Latitude, Longitude}, Monitor),
      handleReceiving(addStation, Pid, ResultMonitor),
      loop(ResultMonitor);

    {request, Pid, addValue, {StationKey, Date, Type, Value}} ->
      ResultMonitor = pollution:addValue(StationKey, Date, Type, Value, Monitor),
      handleReceiving(addValue, Pid, ResultMonitor),
      loop(ResultMonitor);

    {request, Pid, removeValue, {StationKey, Date, Type}} ->
      ResultMonitor = pollution:removeValue(StationKey, Date, Type, Monitor),
      handleReceiving(removeValue, Pid, ResultMonitor),
      loop(ResultMonitor);

    {request, Pid, getOneValue, {StationKey, Date, Type}} ->
      ResultValue = pollution:getOneValue(StationKey, Date, Type, Monitor),
      handleReceiving(getOneValue, Pid, ResultValue),
      loop(Monitor);

    {request, Pid, getStationMean, {StationKey, Type}} ->
      ResultValue = pollution:getStationMean(StationKey, Type, Monitor),
      handleReceiving(getStationMean, Pid, ResultValue),
      loop(Monitor);

    {request, Pid, getDailyMean, {Date, Type}} ->
      ResultValue = pollution:getDailyMean(Date, Type, Monitor),
      handleReceiving(getDailyMean, Pid, ResultValue),
      loop(Monitor);

    {request, Pid, importFromCsv, {FileName}} ->
      ResultMonitor = pollution:importFromCsv(FileName, Monitor),
      handleReceiving(importFromCsv, Pid, ResultMonitor),
      loop(ResultMonitor);

    {request, Pid, stop} ->
      Pid ! {reply, server_stopped}
  end.


handleReceiving(Type, Pid, ResultMonitor) ->
  printCommunicate(Type, ResultMonitor),
  Pid ! {reply, Type}.



call(Command, Args) ->
  case whereis(pollutionServer) of
    undefined -> error_logger:error_msg("UNDEFINED POLLUTION SERVER~n");
    _ -> pollutionServer ! {request, self(), Command, Args},
      receive
        {reply, Reply} -> Reply
      end
  end.



addStation(Name, {Latitude, Longitude}) ->
  call(addStation, {Name, {Latitude, Longitude}}).


addValue(StationKey, Date, Type, Value) ->
  call(addValue, {StationKey, Date, Type, Value}).


removeValue(StationKey, Date, Type) ->
  call(removeValue, {StationKey, Date, Type}).


getOneValue(StationKey, Date, Type) ->
  call(getOneValue, {StationKey, Date, Type}).


getStationMean(StationKey, Type) ->
  call(getStationMean, {StationKey, Type}).


getDailyMean(Date, Type) ->
  call(getDailyMean, {Date, Type}).


importFromCsv(FileName) ->
  call(importFromCsv, {FileName}).



printCommunicate(Type, ReturnValue) ->
  case Type of
    addStation ->
      io:format("~nAdding station to the monitor.~nCurrent monitor state:~n~p~n", [ReturnValue]);

    addValue ->
      io:format("~nAdding value to the station in monitor.~nCurrent monitor state:~n~p~n", [ReturnValue]);

    removeValue ->
      io:format("~nRemoving value from the station in monitor.~nCurrent monitor state:~n~p~n", [ReturnValue]);

    getOneValue ->
      io:format("~nGetting one value:~n~p~n", [ReturnValue]);

    getStationMean ->
      io:format("~nGetting station mean value:~n~p~n", [ReturnValue]);

    getDailyMean ->
      io:format("~nGetting daily mean value:~n~p~n", [ReturnValue]);

    importFromCsv ->
      io:format("Importing data from csv file.~nCurrent monitor state:~n~p~n", [ReturnValue])
  end.