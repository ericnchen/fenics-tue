#!/usr/bin/env bash
set -e

# Deactivate all of the sourced activation scripts.
source "${BUILD_PREFIX}/etc/conda/deactivate.d/deactivate-gfortran_linux-64.sh"
source "${BUILD_PREFIX}/etc/conda/deactivate.d/deactivate-gxx_linux-64.sh"
source "${BUILD_PREFIX}/etc/conda/deactivate.d/deactivate-gcc_linux-64.sh"
source "${BUILD_PREFIX}/etc/conda/deactivate.d/deactivate-binutils_linux-64.sh"

# Source the replacement activation scripts.
source "${BUILD_PREFIX}/etc/conda/activate.d/activate-binutils_linux-64.sh"
source "${RECIPE_DIR}/activate-gcc_linux-64.sh"
source "${RECIPE_DIR}/activate-gxx_linux-64.sh"
source "${RECIPE_DIR}/activate-gfortran_linux-64.sh"

# Need to trim off the full path to the compilers or else it gets baked in.
export CC="$(echo "${GCC}" | xargs -n 1 basename)"
export CXX="$(echo "${GXX}" | xargs -n 1 basename)"
export FC="$(echo "${GFORTRAN}" | xargs -n 1 basename)"
export F77="$(echo "${GFORTRAN}" | xargs -n 1 basename)"

# Unset these variable to make things work for this build.
unset cpu_optimization_target

# Set xFLAGS only for MPICH compilation.
export MPICHLIB_CPPFLAGS="${CPPFLAGS} -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE"
export MPICHLIB_CFLAGS="${CFLAGS} -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE"
export MPICHLIB_CXXFLAGS="${CXXFLAGS} -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE"
export MPICHLIB_FFLAGS="${FFLAGS} -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE"
export MPICHLIB_FCFLAGS="${FCFLAGS} -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE"
export MPICHLIB_LDFLAGS="${LDFLAGS}"
unset CFLAGS CXXFLAGS FFLAGS FCFLAGS LDFLAGS

# Configure.
./configure \
  --enable-fast=all \
  MPICHLIB_CPPFLAGS="${MPICHLIB_CPPFLAGS}" \
  MPICHLIB_CFLAGS="${MPICHLIB_CFLAGS}" \
  MPICHLIB_CXXFLAGS="${MPICHLIB_CXXFLAGS}" \
  MPICHLIB_FFLAGS="${MPICHLIB_FFLAGS}" \
  MPICHLIB_FCFLAGS="${MPICHLIB_FCFLAGS}" \
  MPICHLIB_LDFLAGS="${MPICHLIB_LDFLAGS}" \
  --prefix="${PREFIX}" \
  --enable-shared \
  --disable-static \
  --enable-g=none \
  --enable-threads=multiple \
  --disable-dependency-tracking

make -j "${CPU_COUNT}"
make install

# Just in case it matters, deactivate our custom scripts and activate the original.

# Deactivate.
source "${BUILD_PREFIX}/etc/conda/deactivate.d/deactivate-binutils_linux-64.sh"
source "${RECIPE_DIR}/deactivate-gcc_linux-64.sh"
source "${RECIPE_DIR}/deactivate-gxx_linux-64.sh"
source "${RECIPE_DIR}/deactivate-gfortran_linux-64.sh"

# Reactivate.
source "${BUILD_PREFIX}/etc/conda/activate.d/activate-gfortran_linux-64.sh"
source "${BUILD_PREFIX}/etc/conda/activate.d/activate-gxx_linux-64.sh"
source "${BUILD_PREFIX}/etc/conda/activate.d/activate-gcc_linux-64.sh"
source "${BUILD_PREFIX}/etc/conda/activate.d/activate-binutils_linux-64.sh"

# Clean up the install, and permanently install the new activation scripts.
rm -rf "${PREFIX}/share/man"

mkdir -p "${PREFIX}/etc/conda/activate.d" "${PREFIX}/etc/conda/deactivate.d"
cp "${RECIPE_DIR}/activate-gcc_linux-64.sh"        "${PREFIX}/etc/conda/activate.d/activate-gcc_linux-64.sh"
cp "${RECIPE_DIR}/activate-gfortran_linux-64.sh"   "${PREFIX}/etc/conda/activate.d/activate-gfortran_linux-64.sh"
cp "${RECIPE_DIR}/activate-gxx_linux-64.sh"        "${PREFIX}/etc/conda/activate.d/activate-gxx_linux-64.sh"
cp "${RECIPE_DIR}/deactivate-gcc_linux-64.sh"      "${PREFIX}/etc/conda/deactivate.d/deactivate-gcc_linux-64.sh"
cp "${RECIPE_DIR}/deactivate-gfortran_linux-64.sh" "${PREFIX}/etc/conda/deactivate.d/deactivate-gfortran_linux-64.sh"
cp "${RECIPE_DIR}/deactivate-gxx_linux-64.sh"      "${PREFIX}/etc/conda/deactivate.d/deactivate-gxx_linux-64.sh"
