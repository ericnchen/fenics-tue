#!/usr/bin/env bash
set -e

ln -s "${CC}"  "${CONDA_PREFIX}/bin/gcc"
ln -s "${FC}"  "${CONDA_PREFIX}/bin/gfortran"
ln -s "${CXX}" "${CONDA_PREFIX}/bin/g++"

./configure --prefix="${PREFIX}" --enable-mpi-cxx --enable-mpi-fortran

make -j "${CPU_COUNT}" all
make check
make install
