-module(pollution).
-author("jakub").

%% API
-export([]).
-export([
  createMonitor/0, addStation/3, addValue/5, removeValue/4,
  contains/2, getOneValue/4, getStationMean/3, countMean/1, getDailyMean/3,
  importFromCsv/2
]).

-record(station, {name, coordinates}).
-record(measurement, {date = calendar:local_time(), type, value = 0}).
-record(monitor, {stationsMap = #{}, measurementsMap = #{}}).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              METHOD CREATING AND RETURNING EMPTY MONITOR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

createMonitor() ->
  #monitor{}.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              METHOD ADDING STATION TO THE MONITOR IN ARGUMENT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addStation(Name, {Latitude, Longitude}, Monitor)
  when is_record(Monitor, monitor) and is_number(Latitude) and is_number(Longitude) ->
  case (maps:is_key(Name, Monitor#monitor.stationsMap) or maps:is_key({Latitude, Longitude}, Monitor#monitor.stationsMap)) of
    true ->
      error_logger:error_msg("There is already station with the same name or the same coordinates in the system!
      RETURNING OLD MONITOR~n"),
      Monitor;
    false ->
      Station = #station{name = Name, coordinates = {Latitude, Longitude}},
      StationsMap = Monitor#monitor.stationsMap,
      MeasurementsMap = Monitor#monitor.measurementsMap,
      #monitor{stationsMap = StationsMap#{Name => Station, {Latitude, Longitude} => Station}, measurementsMap = MeasurementsMap}
  end;
addStation(_, _, _)
  -> error_logger:error_msg("Bad arguments in addStation method! Try again").



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              METHOD ADDING VALUE TO SPECIFIC STATION IN GIVEN MONITOR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
            true ->
              error_logger:error_msg("There is already such measurement for station: ~p RETURNING OLD MONITOR ~n", [Station]),
              Monitor;
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
    error:_ -> error_logger:error_msg("There is no such station in the system! Try again, RETURNING OLD MONITOR ~n"),
      Monitor
  end.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              METHOD REMOVING VALUE FROM SPECIFIC STATION IN GIVEN MONITOR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
            false -> error_logger:error_msg("There is no such measurement, RETURNING OLD MONITOR ~n"),
              Monitor
          end
      catch
        error:_ -> error_logger:error_msg("There is no such measurement, RETURNING OLD MONITOR ~n"),
          Monitor
      end
  catch
    error:_ -> error_logger:error_msg("There is no such station, RETURNING OLD MONITOR ~n"),
      Monitor
  end.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              METHOD RETURNING ONE SPECIFIC VALUE
%%              FROM SPECIFIED DATE AND PARAMETER TYPE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              METHOD RETURNING MEAN VALUE OF
%%              SPECIFIC PARAMETER FOR SPECIFIC STATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              METHOD RETURNING MEAN VALUE OF
%%              SPECIFIC PARAMETER FOR SPECIFIC DAY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

getDailyMean(Date, Type, Monitor) ->
  ListOfValues = lists:flatten(maps:values(Monitor#monitor.measurementsMap)),
  countMean(lists:filter(fun(X) -> (X#measurement.type == Type) and (X#measurement.date == Date) end, ListOfValues)).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              METHOD PARSING DATA FROM FILE AND ADDING IT TO MONITOR
%%              (DATA - STATION AND SPECIFIC VALUE FOR THIS STATION)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

importFromCsv(FileName, Monitor) ->
  Lines = readLines(FileName),
  [Name, Coordinates, Date, Type, ValueAsString] = string:lexemes(Lines, ";"),
  CoordinatesTuple = convertStringToTuple(Coordinates),
  Monitor2 = addStation(Name, CoordinatesTuple, Monitor),
  Value = list_to_integer(ValueAsString),
  addValue(Name, Date, Type, Value, Monitor2).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              HELPING METHOD COUNTING MEAN VALUE FOR VALUES IN GIVEN LIST
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

countMean([]) -> 0;
countMean(List) ->
  countSumOfValues(List) / length(List).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              HELPING METHOD COUNTING SUM OF VALUES FOR VALUES IN GIVEN LIST
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

countSumOfValues([]) -> 0;
countSumOfValues([H | T]) ->
  H#measurement.value + countSumOfValues(T).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              HELPING METHOD COUNTING SUM OF VALUES FOR VALUES IN GIVEN LIST
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

contains(_, []) -> false;
contains(Measurement, [Head | Tail]) ->
  case ((Head#measurement.type == Measurement#measurement.type) and (Head#measurement.date == Measurement#measurement.date)) of
    true -> {true, Head, Tail};
    false -> contains(Measurement, Tail)
  end.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              HELPING METHOD CONVERTING STRING TO TUPLE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

convertStringToTuple(String) ->
  {ok, ItemTokens, _} = erl_scan:string(String ++ "."),
  {ok, Term} = erl_parse:parse_term(ItemTokens),
  Term.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              HELPING METHOD READING LINES FROM GIVEN FILE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

readLines(FileName) ->
  {ok, Data} = file:open(FileName, [read]),
  try getAllLinesFromFile(Data)
  after file:close(Data)
  end.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              HELPING METHOD GETTING ALL LINES FROM GIVEN FILES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

getAllLinesFromFile(Data) ->
  case io:get_line(Data, "") of
    eof -> [];
    Line -> Line ++ getAllLinesFromFile(Data)
  end.
