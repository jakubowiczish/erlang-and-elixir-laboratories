-module(reversePolishNotationCalculator).
-author("jakub").

-export([rpn/1]).
-export([calculate/2]).
-export([filter_expression/1]).

%%% 1 + 2 * 3 - 4 / 5 + 6 in rpn: "1 2 3 * 4 5 / - 6 + +"
%%% 1 + 2 + 3 + 4 + 5 + 6 * 7 in rpn: "1 2 + 3 + 4 + 5 + 6 7 * +"
%%% ((4 + 7) / 3) * (2 - 19) in rpn: "4 7 + 3 / 2 19 - *"
%%% 17 * (31 + 4) / ( (26 - 15) * 2 - 22 ) - 1 in rpn: "17 31 4 + * 26 15 - 2 * 22 - / 1 - *"

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
  case string:to_float(H) of
    {error, no_float} ->
      case string:to_integer(H) of
        {error, no_integer} -> exit("Argument is neither int nor float");
        {Int, Rest} ->
          if
            length(Rest) == 0 -> [Int | filter_expression(T)];
            true -> exit("Ivalid argument!")
          end
      end;
    {Float, Rest} ->
      if
        length(Rest) == 0 -> [Float | filter_expression(T)];
        true -> exit("Invalid argument!")
      end
  end.
