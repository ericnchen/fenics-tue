#!/usr/bin/env bash
set -e

source "${RECIPE_DIR}/fix-environment.sh"

cp "${RECIPE_DIR}/Makefile" src/Makefile

cd src

./configure \
  --prefix="${PREFIX}" \
  CPPFLAGS="${CPPFLAGS}" \
  FC=mpifort \
  CC=mpicc \
  CXX=mpicxx \
  FFLAGS="${FFLAGS}" \
  CFLAGS="${CFLAGS}" \
  CXXFLAGS="${CXXFLAGS}" \
  AR="${AR} -rcu" \
  --with-blas-lib="-lopenblas" \
  --with-lapack-lib="-llapack" \
  --with-fei=no

# TODO: For next builds, add:
#        --enable-shared

make

make check
make CHECKRUN="mpirun -np 4" checkpar

make install
