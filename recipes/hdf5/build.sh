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

export LIBRARY_PATH="${PREFIX}/lib"

./configure --prefix="${PREFIX}"    \
            CC=mpicc CFLAGS="-O3"   \
            --disable-cxx           \
            --disable-fortran       \
            --disable-debug         \
            --enable-linux-lfs      \
            --enable-threadsafe     \
            --enable-production     \
            --enable-unsupported    \
            --enable-parallel       \
            --with-pthread=yes      \
            --with-zlib="${PREFIX}" \
            --with-default-plugindir="${PREFIX}/lib/hdf5/plugin"

make -j "${CPU_COUNT}"

# Make the testcases run faster.
export HDF5TestExpress=2
cp "${RECIPE_DIR}/testpar_Makefile.in" testpar/Makefile.in
make check

make install
make check-install

rm -rf "${PREFIX}/share/hdf5_examples"
