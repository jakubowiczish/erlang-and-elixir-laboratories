-module(pollution).
-author("jakub").

%% API
-export([]).

-record(station, {name, coordinates}).
-record(measurement, {type, value = 0, date}).
-record(monitor, {stationsMap = #{}, measurementsMap = #{}}).

createMonitor() ->
  #monitor{}.
