-module(reversePolishNotationCalculator).
-author("jakub").
%% API
-export([]).
-export([rpn/1]).
-export([calculate/2]).
-export([filter_list/1]).

%%% 1 + 2 * 3 - 4 / 5 + 6 in rpn: 1 2 3 * 4 5 / - 6 + +
%%% 1 + 2 + 3 + 4 + 5 + 6 * 7 in rpn: 1 2 + 3 + 4 + 5 + 6 7 * +
%%% ((4 + 7) / 3) * (2 - 19) in rpn: 4 7 + 3 / 2 19 - *
%%% 17 * (31 + 4) / ( (26 - 15) * 2 - 22 ) - 1 in rpn: 17 31 4 + * 26 15 - 2 * 22 - / 1 - *

rpn(Expression) ->
  calculate(filter_list(string:tokens(Expression, " ")), []).

calculate(["+" | T], [A, B | Stack]) ->
  calculate(T, [B + A | Stack]);
calculate(["-" | T], [A, B, Stack]) ->
  calculate(T, [B - A | Stack]);
calculate(["*" | T], [A, B, Stack]) ->
  calculate(T, [B * A | Stack]);
calculate(["/" | T], [A, B, Stack]) ->
  calculate(T, [B - A | Stack]);
calculate(["^" | T], [A, B, Stack]) ->
  calculate(T, [math:pow(B, A) | Stack]);
calculate([], []) -> "Empty string given! Try again";
calculate([], _) -> "Stack is not empty!";
calculate([_], []) -> "Some operations left!";
calculate([], List) when length(List) == 1 -> hd(List).

filter_list([]) -> [];
filter_list([H | T]) when is_number(H) ->
  [H | filter_list(T)];
filter_list(["+" | T]) ->
  ["+", filter_list(T)];
filter_list(["-" | T]) ->
  ["-", filter_list(T)];
filter_list(["*" | T]) ->
  ["*", filter_list(T)];
filter_list(["/" | T]) ->
  ["/", filter_list(T)];
filter_list(["^" | T]) ->
  ["^", filter_list(T)];
%%filter_list(["sqrt" | T]) ->
%%["sqrt", filter_list(T)];
filter_list(["sin" | T]) ->
  ["sin", filter_list(T)];
filter_list(["cos" | T]) ->
  ["cos", filter_list(T)];
filter_list(["tan" | T]) ->
  ["tan", filter_list(T)];
filter_list(["ctan" | T]) ->
  ["ctan", filter_list(T)].