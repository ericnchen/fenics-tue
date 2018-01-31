#!/usr/bin/env bash
set -e

cp "${RECIPE_DIR}/Makefile.inc" Makefile.inc
cp "${RECIPE_DIR}/examples_Makefile" examples/Makefile

export AR="${AR} vr "

# I don't think passing the -j NP flag results in successful builds 100%.
make alllib

# Manually install.
mkdir -p "${PREFIX}/lib" "${PREFIX}/include"
cp lib/*.a "${PREFIX}/lib/."
cp include/*.h "${PREFIX}/include/."

cd examples

make all

# Test the Fortran programs.
export LD_LIBRARY_PATH="${PREFIX}/lib"
mpirun -np "${CPU_COUNT}" ssimpletest < input_simpletest_real
mpirun -np "${CPU_COUNT}" dsimpletest < input_simpletest_real
mpirun -np "${CPU_COUNT}" csimpletest < input_simpletest_cmplx
mpirun -np "${CPU_COUNT}" zsimpletest < input_simpletest_cmplx

# Test the C programs.
mpirun -np "${CPU_COUNT}" c_example

# Test multiple precisions with the Fortran backend.
mpirun -np "${CPU_COUNT}" multiple_arithmetics_example
