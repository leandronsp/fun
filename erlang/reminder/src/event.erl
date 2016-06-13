-module(event).
-compile(export_all).
-record(state, {server,
                name="",
                to_go=0}).

%% Loop uses a list fot times in order to go around the ~49 days limit
%% on timeouts.
loop(S = #state{server=Server, to_go=[T|Next]}) ->
  receive
    {Server, Ref, cancel} ->
      Server ! {Ref, ok}
  after T*1000 ->
    if Next =:= [] ->
        Server ! {done, S#state.name};
       Next =/= [] ->
         loop(S#state{to_go=Next})
     end
  end.

start(EventName, Delay) ->
  spawn(?MODULE, init, [self(), EventName, Delay]).

start_link(EventName, Delay) ->
  spawn_link(?MODULE, init, [self(), EventName, Delay]).

%%% event's innards
init(Server, EventName, Delay) ->
  loop(#state{server=Server,
              name=EventName,
              to_go=normalize(Delay)}).

cancel(Pid) ->
  %% Monitor in case the process is dead
  Ref = erlang:monitor(process, Pid),
  Pid ! {self(), Ref, cancel},
  receive
    {Ref, ok} ->
      erlang:demonitor(Ref, [flush]),
      ok;
    {'DOWN', Ref, process, Pid, _Reason} ->
      ok
  end.

%%% Because Erlang is limited to about 49 days.
normalize(N) ->
  Limit = 49*24*60*60,
  [N rem Limit | lists:duplicate(N div Limit, Limit)].
