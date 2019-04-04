-module(pollution).
-author("jakub").

%% API
-export([]).
-export([createMonitor/0, addStation/3, addValue/5, removeValue/4, contains/2, getOneValue/4, getStationMean/3, countMean/1, getDailyMean/3]).

-record(station, {name, coordinates}).
-record(measurement, {date = calendar:local_time(), type, value = 0}).
-record(monitor, {stationsMap = #{}, measurementsMap = #{}}).


createMonitor() ->
  #monitor{}.


addStation(Name, {Latitude, Longitude}, Monitor)
  when is_record(Monitor, monitor) and is_number(Latitude) and is_number(Longitude) ->
  case (maps:is_key(Name, Monitor#monitor.stationsMap) or maps:is_key({Latitude, Longitude}, Monitor#monitor.stationsMap)) of
    true ->
      error_logger:error_msg("There is already station with the same name or the same coordinates in the system!");
    false ->
      Station = #station{name = Name, coordinates = {Latitude, Longitude}},
      StationsMap = Monitor#monitor.stationsMap,
      MeasurementsMap = Monitor#monitor.measurementsMap,
      #monitor{stationsMap = maps:put(Name, Station, StationsMap), measurementsMap = MeasurementsMap}
  end;
addStation(_, _, _)
  -> error_logger:error_msg("Bad arguments! Try again").


addValue(_, _, _, _, #{}) -> error_logger:error_msg("The monitor is empty!");
addValue(StationKey, Date, Type, Value, Monitor) ->
  StationsMap = Monitor#monitor.stationsMap,
  MeasurementsMap = Monitor#monitor.measurementsMap,
  try maps:get(StationKey, StationsMap) of
    Station ->
      Measurement = #measurement{date = Date, type = Type, value = Value},
      try maps:get(Station, MeasurementsMap) of
        MeasurementsList ->
          case lists:member(Measurement, MeasurementsList) of
            true -> error_logger:error_msg("There is already such measurement for station: ~p", [Station]);
            false -> #monitor{
              stationsMap = StationsMap,
              measurementsMap = MeasurementsMap#{Station := MeasurementsList ++ [Measurement]}
            }
          end
      catch
        error:_ ->
          #monitor{stationsMap = StationsMap, measurementsMap = maps:put(Station, [Measurement], MeasurementsMap)}
      end
  catch
    error:_ -> error_logger:error_msg("There is no such station in the system! Try again~n")
  end.


removeValue(StationKey, Date, Type, Monitor) ->
  StationsMap = Monitor#monitor.stationsMap,
  MeasurementsMap = Monitor#monitor.measurementsMap,
  try maps:get(StationKey, StationsMap) of
    Station ->
      try maps:get(Station, MeasurementsMap) of
        MeasurementsList ->
          Measurement = #measurement{date = Date, type = Type},
          case contains(Measurement, MeasurementsList) of
            {true, _, NewMeasurementsList} ->
              #monitor{stationsMap = StationsMap, measurementsMap = MeasurementsMap#{Station := NewMeasurementsList}};
            false -> error_logger:error_msg("There is no such measurement")
          end
      catch
        error:_ -> error_logger:error_msg("There is no such measurement")
      end
  catch
    error:_ -> error_logger:error_msg("There is no such station!")
  end.


getOneValue(StationKey, Date, Type, Monitor) ->
  StationsMap = Monitor#monitor.stationsMap,
  MeasurementsMap = Monitor#monitor.measurementsMap,
  try maps:get(StationKey, StationsMap) of
    Station ->
      try maps:get(Station, MeasurementsMap) of
        MeasurementsList ->
          Measurement = #measurement{date = Date, type = Type},
          case contains(Measurement, MeasurementsList) of
            {true, NewMeasurement, _} -> NewMeasurement#measurement.value;
            false -> error_logger:error_msg("There is no such measurement")
          end
      catch
        error:_ -> error_logger:error_msg("There is no such measurement")
      end
  catch
    error:_ -> error_logger:error_msg("There is no such station!")
  end.


getStationMean(_, _, {#{}, #{}}) -> error_logger:error_msg("This monitor is empty!");
getStationMean(StationKey, Type, Monitor) ->
  StationsMap = Monitor#monitor.stationsMap,
  MeasurementsMap = Monitor#monitor.measurementsMap,
  try maps:get(StationKey, StationsMap) of
    Station ->
      try maps:get(Station, MeasurementsMap) of
        MeasurementsList -> countMean(lists:filter(fun(X) -> X#measurement.type == Type end, MeasurementsList))
      catch
        error:_ -> 0
      end
  catch
    error:_ -> error_logger:error_msg("There is no such station!")
  end.


getDailyMean(Date, Type, Monitor) ->
  ListOfValues = maps:values(Monitor#monitor.measurementsMap),
  countMean(lists:filter(fun(X) -> (X#measurement.type == Type) and (X#measurement.date == Date) end, ListOfValues)).


countMean([]) -> 0;
countMean(List) ->
  countSumOfValues(List) / length(List).


countSumOfValues([]) -> 0;
countSumOfValues([H | T]) ->
  H#measurement.value + countSumOfValues(T).


contains(_, []) -> false;
contains(Measurement, [Head | Tail]) ->
  case ((Head#measurement.type == Measurement#measurement.type) and (Head#measurement.date == Measurement#measurement.date)) of
    true -> {true, Head, Tail};
    false -> contains(Measurement, Tail)
  end.