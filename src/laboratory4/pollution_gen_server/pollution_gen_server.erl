-module(pollution_gen_server).
-author("jakub").

%% API
-behavior(gen_server).

-export([init/1, handle_call/3, start/1, stop/0, handle_cast/2]).

-export([addStation/2, addValue/4, removeValue/3, getOneValue/3, getStationMean/2, getDailyMean/2, importFromCsv/1]).


start(State) ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, State, []).


init(Monitor) ->
  {ok, Monitor}.


stop() ->
  gen_server:cast(?MODULE, stop).

%% M

addStation(Name, {Latitude, Longitude}) ->
  gen_server:call(?MODULE, {addStation, Name, {Latitude, Longitude}}).


addValue(StationKey, Date, Type, Value) ->
  gen_server:call(?MODULE, {addValue, StationKey, Date, Type, Value}).


removeValue(StationKey, Date, Type) ->
  gen_server:cast(?MODULE, {removeValue, StationKey, Date, Type}).


getOneValue(StationKey, Date, Type) ->
  gen_server:call(?MODULE, {getOneValue, StationKey, Date, Type}).


getStationMean(StationKey, Type) ->
  gen_server:call(?MODULE, {getStationMean, StationKey, Type}).


getDailyMean(Date, Type) ->
  gen_server:call(?MODULE, {getDailyMean, Date, Type}).


importFromCsv(FileName) ->
  gen_server:call(?MODULE, {importFromCsv, FileName}).




%% HANDLERS


handle_call({addStation, Name, {Latitude, Longitude}}, _From, Monitor) ->
  Result = pollution:addStation(Name, {Latitude, Longitude}, Monitor),
  {reply, Result, Result};


handle_call({addValue, StationKey, Date, Type, Value}, _From, Monitor) ->
  Result = pollution:addValue(StationKey, Date, Type, Value, Monitor),
  {reply, Result, Result}.



handle_cast(stop, M) ->
  {stop, normal, M}.




crash() ->
  gen_server:cast(?MODULE, crash).

