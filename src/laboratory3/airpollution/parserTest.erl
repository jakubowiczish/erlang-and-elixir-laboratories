-module(parserTest).
-author("jakub").

%% API
-export([]).
-export([test_reading_lines/0, test_creating_monitor/0]).

test_reading_lines() ->
  pollution:readLines("/home/jakub/IdeaProjects/ErlangLaboratories/src/laboratory3/airpollution/data.csv").
%%  pollution:readLines("/home/jakub/IdeaProjects/ErlangLaboratories/src/laboratory3/airpollution/data.csv").

test_creating_monitor() ->
  pollution:importFromCsv("/home/jakub/IdeaProjects/ErlangLaboratories/src/laboratory3/airpollution/data.csv").