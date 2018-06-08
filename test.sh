#!/bin/bash

export PATH=$(pwd)/bin:$PATH
export LUA_PATH="?.lua;lua/?.lua;proto/?.lua;tests/?.lua;$LUA_PATH;;"

echo "[Compile example.capnp]"
capnp --verbose compile -olua proto/example.capnp proto/enums.capnp proto/lua.capnp proto/struct.capnp || exit

echo "[Unit test...]"
make test  || exit

#Disabled for now
#echo "[capnp_test...]"
#make test1 || exit

#echo
#echo "[Serialization test...]"
#if [ $(uname) != "Linux" ]; then
#    make all || exit
#else
#    CXX=g++-4.7 make all || exit
#
#fi
#cpp/main > a.data || exit
#luajit test.lua c.data || exit
#echo
#echo "capnp c++ result:"
#xxd -g 1 a.data || exit
#echo "capnp lua result:"
#xxd -g 1 c.data || exit
#diff a.data c.data

echo "[Done]"
