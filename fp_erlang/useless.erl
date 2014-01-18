-module(useless).
-export([add/2, hello/0, greet_and_add_two/1, print_hour/0]).
-define(HOUR, 3600).

print_hour() ->
  io:format(integer_to_list(?HOUR)).

add(A,B) ->
  A + B.

%% Shows greetings.
%% io:format/1 is the standard
hello() ->
  io:format('Hello, ~s', ['World']).

greet_and_add_two(X) ->
  hello(),
  add(X, 2).
