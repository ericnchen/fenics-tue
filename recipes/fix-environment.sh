#!/usr/bin/env bash
set -e

# Since this should be a optimized build, change -O2 to -O3.
CFLAGS="${CFLAGS/-O2/-O3}"
CPPFLAGS="${CPPFLAGS/-O2/-O3}"
CXXFLAGS="${CXXFLAGS/-O2/-O3}"
FFLAGS="${FFLAGS/-O2/-O3}"
FORTRANFLAGS="${FORTRANFLAGS/-O2/-O3}"
LDFLAGS="${LDFLAGS/-Wl,-O2/-Wl,-O3}"

# Change the C++ standard library version from C++17 to C++11, since that is
# an older one that FEniCS is designed to work with.
CXXFLAGS="${CXXFLAGS/-std=c++17/-std=c++11}"

# Unset -march.
FFLAGS="${FFLAGS/-march=nocona /}"
FORTRANFLAGS="${FORTRANFLAGS/-march=nocona /}"
CXXFLAGS="${CXXFLAGS/-march=nocona /}"
CFLAGS="${CFLAGS/-march=nocona /}"

# Unset -mtune.
FFLAGS="${FFLAGS/-mtune=haswell /}"
FORTRANFLAGS="${FORTRANFLAGS/-mtune=haswell /}"
CXXFLAGS="${CXXFLAGS/-mtune=haswell /}"
CFLAGS="${CFLAGS/-mtune=haswell /}"

# Unset -fopenmp.
FFLAGS="${FFLAGS/-fopenmp /}"
FORTRANFLAGS="${FORTRANFLAGS/-fopenmp /}"

# Create a FCFLAGS variable.
FCFLAGS="${FFLAGS}"

# Unset these variables that might affect builds.
unset \
  c_compiler \
  cxx_compiler \
  cpu_optimization_target \
  DEBUG_CFLAGS \
  DEBUG_CPPFLAGS \
  DEBUG_CXXFLAGS \
  DEBUG_FFLAGS \
  DEBUG_FORTRANFLAGS \
  fortran_compiler

# Filter out the -fdebug-prefix-map flags.
# Couldn't get it to work with simple substitutions or sed.
filter_fdebug_flags () {
  unset filtered_flags
  local array=(${1})
  for i in "${!array[@]}"
  do
    if [ "${array[i]:0:9}" != "-fdebug-p" ]; then
      if [ -z "${filtered_flags}" ]; then
        filtered_flags="${array[i]}"
      else
        filtered_flags="${filtered_flags} ${array[i]}"
      fi
    fi
  done
  echo "${filtered_flags}"
}

CFLAGS=$(filter_fdebug_flags "${CFLAGS}")
CXXFLAGS=$(filter_fdebug_flags "${CXXFLAGS}")
FCFLAGS=$(filter_fdebug_flags "${FCFLAGS}")
FFLAGS=$(filter_fdebug_flags "${FFLAGS}")
FORTRANFLAGS=$(filter_fdebug_flags "${FORTRANFLAGS}")

# Export all changed variables.
export \
  CFLAGS \
  CPPFLAGS \
  CXXFLAGS \
  FCFLAGS \
  FFLAGS \
  FORTRANFLAGS \
  LDFLAGS
