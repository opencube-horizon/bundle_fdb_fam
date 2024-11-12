# Copyright 2024 European Centre for Medium-Range Weather Forecasts (ECMWF)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

########################################################################################################################

cmake_minimum_required( VERSION 3.12 FATAL_ERROR )

find_package( ecbuild 3.4 REQUIRED HINTS ${CMAKE_CURRENT_SOURCE_DIR} )

project( fdb_fam_bundle VERSION 0.0.1 LANGUAGES CXX )

set( CMAKE_CXX_STANDARD 17 )
set( CMAKE_CXX_STANDARD_REQUIRED ON )

if( Linux_BUNDLE )
    include( Linux.cmake OPTIONAL )
endif()

########################################################################################################################

ecbuild_bundle_initialize()

ecbuild_bundle( PROJECT eckit   GIT "https://github.com/ecmwf/eckit.git"   BRANCH project/opencube UPDATE )
ecbuild_bundle( PROJECT eccodes GIT "https://github.com/ecmwf/eccodes.git" TAG    2.36.0  UPDATE )
ecbuild_bundle( PROJECT metkit  GIT "https://github.com/ecmwf/metkit.git"  TAG    1.11.14 UPDATE )
ecbuild_bundle( PROJECT fdb     GIT "https://github.com/ecmwf/fdb.git"     BRANCH project/opencube UPDATE )

ecbuild_bundle_finalize()
