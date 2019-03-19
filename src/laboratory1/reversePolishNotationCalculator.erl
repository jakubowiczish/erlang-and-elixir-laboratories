%%%-------------------------------------------------------------------
%%% @author radoj
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 06. Mar 2019 13:00
%%%-------------------------------------------------------------------
-module(reversePolishNotationCalculator).
-author("jakub").

%% API
-export([rpn/1]).
-export([calculate/2]).
-export([filter_expression/1]).

rpn(Expression) ->
  calculate(filter_expression(string:tokens(Expression, " ")), []).

calculate([], List) when length(List) == 1 -> hd(List);
calculate([], []) -> "Empty string given! Try again";
calculate([_], []) -> "Some operation needs to be done!";
calculate([], _) -> "Stack is not empty!";
calculate(["+" | T], [A, B | Stack]) ->
  calculate(T, [B + A | Stack]);
calculate(["-" | T], [A, B | Stack]) ->
  calculate(T, [B - A | Stack]);
calculate(["*" | T], [A, B | Stack]) ->
  calculate(T, [B * A | Stack]);
calculate(["/" | T], [A, B | Stack]) ->
  calculate(T, [B / A | Stack]);
calculate(["^" | T], [A, B | Stack]) ->
  calculate(T, [math:pow(B, A) | Stack]);
calculate(["sqrt" | T], [A | Stack]) ->
  calculate(T, [math:sqrt(A) | Stack]);
calculate(["sin" | T], [A | Stack]) ->
  calculate(T, [math:sin(A) | Stack]);
calculate(["cos" | T], [A | Stack]) ->
  calculate(T, [math:cos(A) | Stack]);
calculate(["tan" | T], [A | Stack]) ->
  calculate(T, [math:tan(A) | Stack]);
calculate(["ctan" | T], [A | Stack]) ->
  calculate(T, [1 / math:tan(A) | Stack]);
calculate([H | Stack], L) ->
  calculate(Stack, [H | L]).

filter_expression([]) -> [];
filter_expression(["+" | T]) ->
  ["+" | filter_expression(T)];
filter_expression(["-" | T]) ->
  ["-" | filter_expression(T)];
filter_expression(["/" | T]) ->
  ["/" | filter_expression(T)];
filter_expression(["*" | T]) ->
  ["*" | filter_expression(T)];
filter_expression(["^" | T]) ->
  ["^" | filter_expression(T)];
filter_expression(["sin" | T]) ->
  ["sin" | filter_expression(T)];
filter_expression(["cos" | T]) ->
  ["cos" | filter_expression(T)];
filter_expression(["tan" | T]) ->
  ["tan" | filter_expression(T)];
filter_expression(["ctan" | T]) ->
  ["ctan" | filter_expression(T)];
filter_expression(["sqrt" | T]) ->
  ["sqrt" | filter_expression(T)];
filter_expression([H | T]) ->
  [list_to_integer(H) | filter_expression(T)].
