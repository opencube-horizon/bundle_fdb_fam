macro( set_verbose )
    set( ${ARGV} )
    message( STATUS "SETTING -> ${ARGV0} = ${ARGV1}" )
endmacro()

set_verbose( CMAKE_INSTALL_PREFIX "/shared/members/ECMWF/software/${CMAKE_HOST_SYSTEM_PROCESSOR}" )

set_verbose( ENV{OpenFAM_ROOT} "/shared/WP/3/OpenFam/${CMAKE_HOST_SYSTEM_PROCESSOR}/install/" )
set_verbose( ENV{LD_LIBRARY_PATH} "/shared/WP/3/OpenFam/${CMAKE_HOST_SYSTEM_PROCESSOR}/install/lib:$ENV{LD_LIBRARY_PATH}" )
set_verbose( ENV{LD_LIBRARY_PATH} "/shared/WP/3/OpenFam/${CMAKE_HOST_SYSTEM_PROCESSOR}/install/lib64:$ENV{LD_LIBRARY_PATH}" )

set_verbose( ENABLE_NETCDF           OFF  CACHE  BOOL "NetCDF" FORCE)
set_verbose( ENABLE_DUMMY_TAPES      OFF  CACHE  BOOL "Build dummy tape interface" FORCE)
set_verbose( ENABLE_JPG              OFF  CACHE  BOOL "no JPG" FORCE)
set_verbose( ENABLE_AEC              OFF  CACHE  BOOL "no AEC" FORCE)
set_verbose( ENABLE_POINTDB          ON   CACHE  BOOL "PointDB" FORCE)
set_verbose( ENABLE_MEMFS            ON   CACHE  BOOL "GRIB MemFS" FORCE)
set_verbose( ENABLE_PYTHON           ON   CACHE  BOOL "python" FORCE)
set_verbose( ENABLE_ECCODES          ON   CACHE  BOOL "Enable eccodes" FORCE )
set_verbose( ENABLE_ECCODES_THREADS  ON   CACHE  BOOL "Enable GRIB threading" FORCE )
set_verbose( ENABLE_FORTRAN          OFF  CACHE  BOOL "no Fortran" FORCE )
set_verbose( ENABLE_MPI              OFF  CACHE  BOOL "no MPI" FORCE )
set_verbose( ENABLE_EXAMPLES         OFF  CACHE  BOOL "no examples" FORCE )
set_verbose( ENABLE_EXPERIMENTAL     OFF  CACHE  BOOL "no experimental" FORCE )
set_verbose( ENABLE_OPENFAM          ON   CACHE  BOOL "ECKIT FAM support" FORCE )
set_verbose( ENABLE_FAMFDB           ON   CACHE  BOOL "FDB FAM support" FORCE )
