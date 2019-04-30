-module(pollution_server).
-author("jakub").

%% API
-export([start/0, init/0]).

-record(station, {name, coordinates}).
-record(measurement, {date = calendar:local_time(), type, value = 0}).
-record(monitor, {stationsMap = #{}, measurementsMap = #{}}).


start() ->
  register(pollutionServer, spawn(pollution_server, init, [])).



init() ->
  Monitor = pollution:createMonitor(),
  loop(Monitor).



%%loop(Monitor) ->
%%  receive
%%    {request, Pid, addStation, Name, {Latitude, Longitude}} ->
%%      Result = pollution:addStation(Name, {Latitude, Longitude}),
%%
%%
%%  end.



handleResult(Result, Pid, Monitor) ->
  case Result of
    {error, Report} ->
      Pid ! {reply, Report},
      loop(Monitor);
    _ ->
      Pid ! {reply, ok},
      loop(Result)
  end.


call(Request, Args) ->
  pollutionServer ! {request, self(), Request, Args},
  receive
    {reply, Reply} -> Reply
  end.


addStation(Name, {Latitude, Longitude}) -> call(addStation, {Name, {Latitude, Longitude}}).




stop() ->
  pollutionServer ! {request, self(), stop},
  receive
    {reply, Reply} -> Reply
  end.

call(Command, Arguments) ->
  pollutionServer ! {request, self(), Command, Arguments},
  receive
    {reply, Reply} ->
      Reply
  end.
