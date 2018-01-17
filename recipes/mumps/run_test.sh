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

cp "${RECIPE_DIR}/Makefile.inc"      Makefile.inc
cp "${RECIPE_DIR}/examples_Makefile" examples/Makefile

cd examples

make all

# Test the Fortran programs.
mpirun -np "${CPU_COUNT}" ssimpletest < input_simpletest_real
mpirun -np "${CPU_COUNT}" dsimpletest < input_simpletest_real
mpirun -np "${CPU_COUNT}" csimpletest < input_simpletest_cmplx
mpirun -np "${CPU_COUNT}" zsimpletest < input_simpletest_cmplx

# Test the C programs.
mpirun -np "${CPU_COUNT}" c_example

# Test multiple precisions with the Fortran backend.
mpirun -np "${CPU_COUNT}" multiple_arithmetics_example
