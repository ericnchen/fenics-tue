#!/usr/bin/env bash
set -e

# Unset the default compile/link flags that the conda compiler tools set.
unset \
  DEBUG_FORTRANFLAGS \
  CXXFLAGS \
  DEBUG_CXXFLAGS \
  DEBUG_FFLAGS \
  FORTRANFLAGS \
  CFLAGS \
  DEBUG_CFLAGS \
  FFLAGS

cp "${RECIPE_DIR}/Makefile.inc" src/Makefile.inc

cd src

export CPATH="${CONDA_PREFIX}/include:${CPATH}"

make -j "${CPU_COUNT}" scotch
make -j "${CPU_COUNT}" ptscotch

# These next two can not be built with multiple workers.
make esmumps
make ptesmumps

make prefix="${PREFIX}" install

rm -rf "${PREFIX}/share"
