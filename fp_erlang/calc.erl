-module(calc).

-export([rpn/1, rpn/2, read/1]).

rpn(Input) when is_list(Input) ->
  [Result] = lists:foldl(fun rpn/2, [], string:tokens(Input, " ")),
  Result.

rpn(X, []) -> [read(X)];
rpn("+", [N1,N2|S]) -> [N2+N1|S];
rpn("-", [N1,N2|S]) -> [N2-N1|S];
rpn("*", [N1,N2|S]) -> [N2*N1|S];
rpn("/", [N1,N2|S]) -> [N2/N1|S];
rpn("^", [N1,N2|S]) -> [math:pow(N2,N1)|S];
rpn("ln", [N|S])    -> [math:log(N)|S];
rpn("log10", [N|S]) -> [math:log10(N)|S];

% logB(N)
rpn(X, Stack = [N|S]) ->
  case re:run(X, "^log*") of
    { match, _ } ->
      [_, B] = re:split(X, "log"),
      _Base = read(binary_to_list(B)),
      _Result = math:log(N) / math:log(_Base),
      [_Result|S];
    _ -> [read(X)|Stack]
  end.

read(N) ->
  try
    list_to_float(N)
  catch
    _:_ ->
      try
        list_to_integer(N)
      catch
        _:_ -> N
      end
  end.
