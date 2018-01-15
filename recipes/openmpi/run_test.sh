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

cd examples
make mpi

mpirun -np 4 hello_cxx
mpirun -np 4 hello_mpifh
mpirun -np 4 hello_usempi
mpirun -np 4 hello_usempif08
mpirun -np 4 ring_cxx
mpirun -np 4 ring_mpifh
mpirun -np 4 ring_usempi
mpirun -np 4 ring_usempif08
