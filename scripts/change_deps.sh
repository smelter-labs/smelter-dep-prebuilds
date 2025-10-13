#!/usr/bin/env bash

#
# For each built dynamic library:
#   - Remove prefix from its install name (e.g. /usr/local/lib/libavcodec.62.dylib => libavcode.62.dylib)
#   - Change its dependecies pointing to other libav libraries from absolute with /usr/local/lib prefix
#     to relative to @loader_path so they can see each other for as long as they are in the same directory
#

set -eo pipefail

if (( $# != 1 )); then
    echo "Usage: $0 <SEARCH_DIR>"
    exit 1
fi

SEARCH_DIR=$1

for f in ${SEARCH_DIR}/lib/*.dylib; do
    deps_to_change=$(otool -L $f | awk -F" " '{print $1}' | grep -E "^/usr/local/lib")
    lib_name=$(basename $f)
    install_name_tool -id $lib_name $f
    for lib in $deps_to_change; do
        install_name_tool -change "$lib" "@loader_path/$(basename $lib)" $f
    done
done
