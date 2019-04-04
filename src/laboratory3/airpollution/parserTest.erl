-module(parserTest).
-author("jakub").

%% API
-export([]).
-export([test_parser/0]).

test_parser() ->
  csvParser:showFile("/home/jakub/IdeaProjects/ErlangLaboratories/src/laboratory3/airpollution/data.csv").