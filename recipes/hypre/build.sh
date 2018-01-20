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

cp "${RECIPE_DIR}/Makefile" src/Makefile

cd src

./configure --prefix="${PREFIX}" \
  CPPFLAGS="-I${PREFIX}/include" \
  CC=mpicc                       \
  CXX=mpicxx                     \
  FC=mpifort                     \
  FFLAGS="-O3 -fPIC"             \
  CFLAGS="-O3 -fPIC"             \
  CXXFLAGS="-O3 -fPIC"           \
  AR="${AR} -rcu"                \
  --with-blas-lib="${PREFIX}/lib/libopenblas.so" \
  --with-lapack-lib="${PREFIX}/lib/liblapack.so" \
  --with-fei=no

make

make check
make CHECKRUN="mpirun -np 4" checkpar

make install
