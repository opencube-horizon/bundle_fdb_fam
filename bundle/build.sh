#!/usr/bin/env bash

ARCH=$(uname -m)

BUILD_DIR=./build/$ARCH

export OpenFAM_ROOT="/shared/WP/3/OpenFam/$ARCH/install/"
export LD_LIBRARY_PATH="/shared/WP/3/OpenFam/$ARCH/install/lib:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="/shared/WP/3/OpenFam/$ARCH/install/lib64:$LD_LIBRARY_PATH"

cmake --build "$BUILD_DIR" --target all
