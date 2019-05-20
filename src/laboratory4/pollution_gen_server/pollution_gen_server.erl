-module(pollution_gen_server).
-author("jakub").

%% API
-behavior(gen_server).

-export([
  init/1,
  handle_call/3,
  start/1,
  stop/0,
  handle_cast/2
]).

-export([
  addStation/2,
  addValue/4,
  removeValue/3,
  getOneValue/3,
  getStationMean/2,
  getDailyMean/2,
  importFromCsv/1,
  crash/0,
  terminate/2]).


start(InitMonitor) ->
  [{lastState, State}] = ets:lookup(monitorKeeper, lastState),
  gen_server:start_link({local, ?MODULE}, ?MODULE, State, []).


init(Monitor) ->
  {ok, Monitor}.


stop() ->
  gen_server:cast(?MODULE, stop).


terminate(normal, Monitor) ->
  io:format("Final state of the monitor:~n~w~n", [Monitor]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                              POLLUTION METHODS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


addStation(Name, {Latitude, Longitude}) ->
  gen_server:call(?MODULE, {addStation, Name, {Latitude, Longitude}}).


addValue(StationKey, Date, Type, Value) ->
  gen_server:call(?MODULE, {addValue, StationKey, Date, Type, Value}).


removeValue(StationKey, Date, Type) ->
  gen_server:call(?MODULE, {removeValue, StationKey, Date, Type}).


getOneValue(StationKey, Date, Type) ->
  gen_server:call(?MODULE, {getOneValue, StationKey, Date, Type}).


getStationMean(StationKey, Type) ->
  gen_server:call(?MODULE, {getStationMean, StationKey, Type}).


getDailyMean(Date, Type) ->
  gen_server:call(?MODULE, {getDailyMean, Date, Type}).


importFromCsv(FileName) ->
  gen_server:call(?MODULE, {importFromCsv, FileName}).


crash() ->
  gen_server:cast(?MODULE, crash).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                              CALL HANDLERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


handle_call({addStation, Name, {Latitude, Longitude}}, _From, Monitor) ->
  Result = pollution:addStation(Name, {Latitude, Longitude}, Monitor),
  {reply, Result, Result};


handle_call({addValue, StationKey, Date, Type, Value}, _From, Monitor) ->
  Result = pollution:addValue(StationKey, Date, Type, Value, Monitor),
  {reply, Result, Result};


handle_call({removeValue, StationKey, Date, Type}, _From, Monitor) ->
  Result = pollution:removeValue(StationKey, Date, Type, Monitor),
  {reply, Result, Result};


handle_call({getOneValue, StationKey, Date, Type}, _From, Monitor) ->
  Result = pollution:getOneValue(StationKey, Date, Type, Monitor),
  {reply, Result, Monitor};


handle_call({getStationMean, StationKey, Type}, _From, Monitor) ->
  Result = pollution:getStationMean(StationKey, Type, Monitor),
  {reply, Result, Monitor};


handle_call({getDailyMean, Date, Type}, _From, Monitor) ->
  Result = pollution:getDailyMean(Date, Type, Monitor),
  {reply, Result, Monitor};


handle_call({importFromCsv, Filename}, _From, Monitor) ->
  Result = pollution:importFromCsv(Filename, Monitor),
  {reply, Result, Result}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                              CAST HANDLERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


handle_cast(stop, Monitor) ->
  {stop, normal, Monitor};


handle_cast(crash, Monitor) ->
  ets:insert(monitorKeeper, [{lastState, Monitor}]),
  1 / 0,
  {noreply, Monitor}.
