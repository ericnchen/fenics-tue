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
export FC="$(echo "${GFORTRAN}" | xargs -n 1 basename)"
export CC="$(echo "${GCC}" | xargs -n 1 basename)"
export CXX="$(echo "${GXX}" | xargs -n 1 basename)"

# Unset these variable to make things work for this build.
unset cpu_optimization_target

# Configure.
./configure \
  --disable-static \
  --disable-dependency-tracking \
  --enable-mpi-fortran \
  --enable-mpi-cxx \
  --disable-oshmem \
  --enable-mpi-thread-multiple \
  --without-slurm \
  --disable-dlopen \
  --prefix="${PREFIX}"

# Compile.
make -j "${CPU_COUNT}" all

# Test.
make check
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
