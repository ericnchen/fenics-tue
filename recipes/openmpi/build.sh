#!/usr/bin/env bash
set -e

source "${RECIPE_DIR}/fix-environment.sh"

# Need to trim off the full path to the compilers or else it gets baked in.
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
  --disable-dlopen \
  --prefix="${PREFIX}"

make -j "${CPU_COUNT}" all
make check
make install

rm -rf "${PREFIX}/share/man"
