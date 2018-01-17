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

ln -s "${RECIPE_DIR}/Makefile.inc" Makefile.inc

export AR="${AR} vr "

# I don't think passing the -j NP flag results in successful builds 100%.
make alllib

# Manually install.
cp lib/*.a     "${PREFIX}/lib"
cp include/*.h "${PREFIX}/include"
