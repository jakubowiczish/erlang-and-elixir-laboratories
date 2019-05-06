-module(incrementator).
-author("jakub").

%% API
-export([start_link/0, increment/1, get/1, close/1, init/1]).
-export([handle_cast/2, handle_call/3, terminate/2]).
-export([test_incrementator_module/0]).

%% START %%

start_link() ->
  gen_server:start_link(?MODULE, 0, []).


%% CLIENT -> SERVER INTERFACE %%

increment(Pid) ->
  gen_server:cast(Pid, inc).


get(Pid) ->
  gen_server:call(Pid, get).


close(Pid) ->
  gen_server:call(Pid, terminate).


init(N) ->
  {ok, N}.


%% MESSAGES HANDLING %%

handle_cast(inc, N) ->
  {noreply, N + 1}.


handle_call(get, _From, N) ->
  {reply, N, N};
handle_call(terminate, _From, N) ->
  {stop, normal, ok, N}.


terminate(normal, N) ->
  io:format("The number is ~B~nBye bye!~n~n", [N]),
  ok.


%% TESTING METHOD %%

test_incrementator_module() ->
  {ok, Pid} = incrementator:start_link(),
  incrementator:increment(Pid),
  incrementator:increment(Pid),
  incrementator:close(Pid).
