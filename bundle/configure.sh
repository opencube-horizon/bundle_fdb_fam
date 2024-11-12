#!/usr/bin/env bash

ARCH=$(uname -m)
SYS=$(uname -s)

BUILD_DIR=./build/$ARCH

rm -rf "$BUILD_DIR"

export OpenFAM_ROOT="/shared/WP/3/OpenFam/$ARCH/install/"
export LD_LIBRARY_PATH="/shared/WP/3/OpenFam/$ARCH/install/lib:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="/shared/WP/3/OpenFam/$ARCH/install/lib64:$LD_LIBRARY_PATH"

# -DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo

cmake --no-warn-unused-cli -D"${SYS}_BUNDLE"=1 -DCMAKE_INSTALL_PREFIX="/shared/members/ECMWF/software/$ARCH" -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_COLOR_DIAGNOSTICS:BOOL=TRUE -DCMAKE_COLOR_MAKEFILE:BOOL=TRUE -B"$BUILD_DIR" -G Ninja

echo "export PATH=\"$BUILD_DIR/bin:\$PATH\""
echo "export ECCODES_DEFINITION_PATH=\"$BUILD_DIR/share/eccodes/definitions/\""
