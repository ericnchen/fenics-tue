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

cp "${RECIPE_DIR}/blacstest.f" TESTING/blacstest.f
cp "${RECIPE_DIR}/Makefile.TESTING" TESTING/Makefile

make tester

cd "${PREFIX}"
ln -s "${RECIPE_DIR}/bsbr.dat" bsbr.dat
ln -s "${RECIPE_DIR}/bt.dat" bt.dat
ln -s "${RECIPE_DIR}/comb.dat" comb.dat
ln -s "${RECIPE_DIR}/sdrv.dat" sdrv.dat

mpirun -np "${CPU_COUNT}" xFbtest
mpirun -np "${CPU_COUNT}" xCbtest
