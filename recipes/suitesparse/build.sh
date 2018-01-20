#!/usr/bin/env bash

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

unset CPPFLAGS

cp "${RECIPE_DIR}/SuiteSparse_config.mk" SuiteSparse_config/SuiteSpare_config.mk

make \
  MY_METIS_INC="${PREFIX}/include" \
  MY_METIS_LIB=["${PREFIX}/lib/libscotchmetis.a","${PREFIX}/lib/libscotcherr.a","${PREFIX}/lib/libpord.a"]
