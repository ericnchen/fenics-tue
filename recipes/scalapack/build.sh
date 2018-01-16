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

cp "${RECIPE_DIR}/SLmake.inc" SLmake.inc
cp "${RECIPE_DIR}/Makefile.TOOLS" TOOLS/Makefile

make toolslib pblaslib redistlib scalapacklib

mkdir "${PREFIX}/lib"
cp libscalapack.a "${PREFIX}/lib/libscalapack.a"
