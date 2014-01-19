-module(exceptions).
-compile(export_all).

throws(F) ->
  try F() of
    _ -> ok
  catch
    Throw -> { throw, caught, Throw }
  end.

errors(F) ->
  try F() of
    _ -> ok
  catch
    error:Error -> { error, caught, Error }
  end.

exits(F) ->
  try F() of
    _ -> ok
  catch
    exit:Exit -> { exit, caught, Exit }
  end.

sword(1) -> throw(slice);
sword(2) -> erlang:error(cut_arm);
sword(3) -> exit(cut_leg);
sword(4) -> throw(punch);
sword(5) -> exit(cross_bridge).

black_knight(Attack) when is_function(Attack, 0) ->
  try Attack() of
    _ -> 'None shall pass'
  catch
    throw:slice -> 'It is but a scratch';
    error:cut_arm -> "I've had worse";
    exit:cut_leg -> 'Come on you pansy!';
    _:_ -> 'Just a flesh wound'
  end.

talk() -> 'blah blah'.

im_impressed() ->
  try
    talk(),
    _Kight = 'None shall pass',
    throw(up),
    _WillReturnThis = 'tequila'
  catch
    throw:ups -> 'Pattern matching is beautiful';
    Exception:Reason -> { Exception, Reason }
  end.
