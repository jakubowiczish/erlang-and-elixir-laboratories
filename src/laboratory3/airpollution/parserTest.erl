-module(parserTest).
-author("jakub").

%% API
-export([]).
-export([test_reading_lines/0]).

test_reading_lines() ->
  pollution:showCsvContent("/home/jakub/IdeaProjects/ErlangLaboratories/src/laboratory3/airpollution/data.csv").
%%  pollution:readLines("/home/jakub/IdeaProjects/ErlangLaboratories/src/laboratory3/airpollution/data.csv").
%%  pollution:readLines("/home/jakub/IdeaProjects/ErlangLaboratories/src/laboratory3/airpollution/data.csv").

