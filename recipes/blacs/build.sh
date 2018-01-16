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

cp "${RECIPE_DIR}/Makefile.MPI" SRC/MPI/Makefile
mkdir "${PREFIX}/lib"

make mpi
