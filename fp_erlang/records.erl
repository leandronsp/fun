-module(records).
-compile(export_all).

-record(robot, { name, type=industrial, hobbies, details=[] }).
-include("user.hrl").

first_robot() ->
  #robot{name="Mechatron", type=handmade, details=["My details"]}.

first_user() ->
  #user{name="Leandro", type=admin, bio="Awesome"}.
