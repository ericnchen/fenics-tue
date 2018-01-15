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

ln -s "${GCC}" "${CONDA_PREFIX}/bin/gcc"
ln -s "${GXX}" "${CONDA_PREFIX}/bin/g++"
ln -s "${GFORTRAN}" "${CONDA_PREFIX}/bin/gfortran"

./configure \
  CC=gcc CXX=g++ FC=gfortran \
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
