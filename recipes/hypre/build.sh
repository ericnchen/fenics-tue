#!/usr/bin/env bash
set -e

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
  LDFLAGS="${LDFLAGS}" \
  AR="${AR} -rcu" \
  --with-blas-lib="-lopenblas" \
  --with-lapack-lib="-llapack" \
  --with-fei=no

make

make check
make CHECKRUN="mpirun -np 4" checkpar

make install
