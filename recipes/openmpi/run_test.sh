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

cd examples

make hello_c ring_c mpi

mpirun -np "${CPU_COUNT}" hello_c
mpirun -np "${CPU_COUNT}" hello_cxx
mpirun -np "${CPU_COUNT}" hello_mpifh
mpirun -np "${CPU_COUNT}" hello_usempi
mpirun -np "${CPU_COUNT}" hello_usempif08

mpirun -np "${CPU_COUNT}" ring_c
mpirun -np "${CPU_COUNT}" ring_cxx
mpirun -np "${CPU_COUNT}" ring_mpifh
mpirun -np "${CPU_COUNT}" ring_usempi
mpirun -np "${CPU_COUNT}" ring_usempif08
