-module(pollution).
-author("jakub").

%% API
-export([]).
-export([createMonitor/0, addStation/3]).

-record(station, {name, coordinates}).
-record(measurement, {type, value = 0, date = calendar:local_time()}).
-record(monitor, {stationsMap = #{}, measurementsMap = #{}}).

createMonitor() ->
  #monitor{}.

addStation(Name, {Latitude, Longitude}, Monitor)
  when is_record(Monitor, monitor) and is_number(Latitude) and is_number(Longitude) ->
  case (maps:is_key(Name, Monitor#monitor.stationsMap) or maps:is_key({Latitude, Longitude}, Monitor#monitor.stationsMap)) of
    true -> error_logger:error_msg("There is already station with the same name or the same coordinates in the system");
    false ->
      Station = #station{name = Name, coordinates = {Latitude, Longitude}},
      StationsMap = Monitor#monitor.stationsMap,
      MeasurementsMap = Monitor#monitor.measurementsMap,
      #monitor{stationsMap = maps:put(Name, Station, StationsMap), measurementsMap = MeasurementsMap}
  end;
addStation(_, _, _)
  -> error_logger:error_msg("Bad arguments! Try again").
