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

cp "${RECIPE_DIR}/SLmake.inc"     SLmake.inc
cp "${RECIPE_DIR}/TOOLS_Makefile" TOOLS/Makefile

make toolslib pblaslib redistlib scalapacklib

mkdir "${PREFIX}/lib"
mv libscalapack.a "${PREFIX}/lib/libscalapack.a"
