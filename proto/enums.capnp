@0xa7e0ba9e3ca0988d;

using Lua = import "lua.capnp";

enum EnumType2 $Lua.naming("lower_underscore") {
    enum5 @0;
    enum6 @1;
    enum7 @2;
    upperDash @3 $Lua.naming("upper_dash");
    lowerUnderScore @4 $Lua.naming("lower_underscore");
    upperUnderScore @5 $Lua.naming("upper_underscore");
}
