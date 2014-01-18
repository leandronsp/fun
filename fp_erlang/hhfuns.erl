-module(hhfuns).
-compile(export_all).

map(_, []) -> [];
map(F, [H|T]) -> [F(H) | map(F,T)].

filter(Pred, L) -> lists:reverse(filter(Pred, L, [])).

filter(_, [], Acc) -> Acc;
filter(Pred, [H|T], Acc) ->
  case Pred(H) of
    true  -> filter(Pred, T, [H|Acc]);
    false -> filter(Pred, T, Acc)
  end.

fold(_, Memo, []) -> Memo;
fold(F, Memo, [H|T]) -> fold(F, F(H, Memo), T).

reverse(L) ->
  fold(fun(X, Acc) -> [X|Acc] end, [], L).
