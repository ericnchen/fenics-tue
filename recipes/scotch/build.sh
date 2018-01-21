#!/usr/bin/env bash
set -e

source "${RECIPE_DIR}/fix-environment.sh"

cp "${RECIPE_DIR}/Makefile.inc" src/Makefile.inc

cd src

make -j "${CPU_COUNT}" scotch
make -j "${CPU_COUNT}" ptscotch

# These next two can not be built with multiple workers.
make esmumps
make ptesmumps

(cd check && make check)
(cd check && make ptcheck)

make prefix="${PREFIX}" install

# Copy the additional esmumps outputs that the above didn't copy.
cp ../include/esmumps.h  "${PREFIX}/include/esmumps.h"
cp ../include/metis.h    "${PREFIX}/include/metis.h"
cp ../include/parmetis.h "${PREFIX}/include/parmetis.h"
cp ../lib/libesmumps.a   "${PREFIX}/lib/libesmumps.a"
cp ../lib/libptesmumps.a "${PREFIX}/lib/libptesmumps.a"

rm -rf "${PREFIX}/share"
