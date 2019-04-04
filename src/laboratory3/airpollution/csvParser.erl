-module(csvParser).
-author("jakub").

%% API
-export([]).
-export([parseFile/1, parse/1, showFile/1, readLines/1]).

showFile(FilePath) ->
  {ok, File} = file:open(FilePath, read),
  FileContent = file:read(File, 1024 * 1024),
  io:format("~p~n", [FileContent]).

readLines(FileName) ->
  {ok, Data} = file:read_file(FileName),
  binary:split(Data, [<<"\n">>], [global]).


parseFile(File) ->
  {ok, Data} = file:read_file(File),
  parse(Data).

parse(Data) ->
  Lines = re:split(Data, "\r|\n|\r\n", []),
  [[begin
      case re:split(Token, "\"", []) of
        [_, T, _] -> T;
        [] -> <<"">>
      end
    end || Token <- re:split(Line, ",", [])] || Line <- Lines, Line =/= <<"">>].