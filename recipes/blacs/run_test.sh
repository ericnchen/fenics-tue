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

cp "${RECIPE_DIR}/TESTING_Makefile"    TESTING/Makefile
cp "${RECIPE_DIR}/TESTING_blacstest.f" TESTING/blacstest.f

make tester

ln -s "${SRC_DIR}/TESTING/bt.dat"   "${PREFIX}/bt.dat"
ln -s "${SRC_DIR}/TESTING/bsbr.dat" "${PREFIX}/bsbr.dat"
ln -s "${SRC_DIR}/TESTING/comb.dat" "${PREFIX}/comb.dat"
ln -s "${SRC_DIR}/TESTING/sdrv.dat" "${PREFIX}/sdrv.dat"

cd "${PREFIX}"

mpirun -np "${CPU_COUNT}" xCbtest
mpirun -np "${CPU_COUNT}" xFbtest
