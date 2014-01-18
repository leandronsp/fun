-module(tree).
-export([empty/0, insert/3, lookup/2]).
-define(EMPTY, { node, 'nil' }).

empty() -> ?EMPTY.

insert(Key, Val, ?EMPTY) ->
  { node, { Key, Val, ?EMPTY, ?EMPTY }};
insert(NewKey, NewVal, { node, { Key, Val, Smaller, Larger }}) when NewKey < Key ->
  { node, { Key, Val, insert(NewKey, NewVal, Smaller), Larger }};
insert(NewKey, NewVal, { node, { Key, Val, Smaller, Larger }}) when NewKey > Key ->
  { node, { Key, Val, Smaller, insert(NewKey, NewVal, Larger) }};
insert(Key, Val, { node, { Key, _, Smaller, Larger }}) ->
  { node, { Key, Val, Smaller, Larger }}.

lookup(_, ?EMPTY) -> undefined;
lookup(Key, { node, { Key, Val, _, _ }}) ->
  { ok, Val };
lookup(Key, { node, { NodeKey, _, Smaller, _ }}) when Key < NodeKey ->
  lookup(Key, Smaller);
lookup(Key, { node, { _, _, _, Larger }}) ->
  lookup(Key, Larger).
