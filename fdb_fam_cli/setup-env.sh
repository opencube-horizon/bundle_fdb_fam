#!/usr/bin/env bash

export OPENFAM_ROOT="/shared/members/ECMWF/software/fam/x86_64"
export OPENFAM_INSTALL_DIR="/shared/WP/3/OpenFam/$HOSTTYPE/install"
export LD_LIBRARY_PATH="$OPENFAM_INSTALL_DIR/lib:$OPENFAM_INSTALL_DIR/lib64:/opt/cray/libfabric/1.20.1/lib64:$LD_LIBRARY_PATH"
export PATH="$HOME/FDB_FAM_D42/bundle/build/$HOSTTYPE/bin:$OPENFAM_INSTALL_DIR/bin:$PATH"
