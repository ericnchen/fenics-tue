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

export FC="$(echo "${GFORTRAN}" | xargs -n 1 basename)"
export CC="$(echo "${GCC}" | xargs -n 1 basename)"
export CXX="$(echo "${GXX}" | xargs -n 1 basename)"

./configure \
  --disable-static \
  --disable-dependency-tracking \
  --enable-mpi-fortran \
  --enable-mpi-cxx \
  --disable-oshmem \
  --enable-mpi-thread-multiple \
  --without-slurm \
  --prefix="${PREFIX}"

make -j "${CPU_COUNT}" all
make check
make install
