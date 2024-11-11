#!/usr/bin/env bash

BUILD_DIR=./build/$(uname -m)

rm -rf $BUILD_DIR

# -DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo

MC_INSTALL=1 cmake --no-warn-unused-cli -D$(uname -s)_BUNDLE=1 -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_COLOR_DIAGNOSTICS:BOOL=TRUE -DCMAKE_COLOR_MAKEFILE:BOOL=TRUE -DCMAKE_PROJECT_INCLUDE:STRING="$HOME/workspace/.cmake/project_hook.cmake" -B"$BUILD_DIR" -G Ninja

echo "export PATH=\"$BUILD_DIR/bin:\$PATH\""
echo "export ECCODES_DEFINITION_PATH=\"$BUILD_DIR/share/eccodes/definitions/\""
