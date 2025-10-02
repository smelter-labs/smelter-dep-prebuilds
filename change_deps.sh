#!/usr/bin/env bash

for f in lib/*.dylib; do
    deps_to_change=$(otool -L $f | awk -F" " '{print $1}' | grep -E "^/usr/local/lib")
    lib_name=$(basename $f)
    install_name_tool -id $lib_name $f
    for lib in $deps_to_change; do
        install_name_tool -change "$lib" "@loader_path/$(basename $lib)" $f
    done
done
