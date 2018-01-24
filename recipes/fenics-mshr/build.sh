#!/usr/bin/env bash
set -e

source "${RECIPE_DIR}/fix-environment.sh"

#INCLUDE_PATH="${PREFIX}/include"
#LIBRARY_PATH="${PREFIX}/lib"
#  -DCMAKE_INCLUDE_PATH="${INCLUDE_PATH}" \
#  -DCMAKE_LIBRARY_PATH="${LIBRARY_PATH}" \
#  -DBOOST_ROOT="${PREFIX}" \

#export LDFLAGS="-Wl,-rpath,${LIBRARY_PATH} ${LDFLAGS}"

rm -rf build && mkdir build

cd build

cmake .. \
  -DCMAKE_C_COMPILER=mpicc \
  -DCMAKE_CXX_COMPILER=mpicxx \
  -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
  -DENABLE_TESTS=1 \
  -DMSHR_ENABLE_VTK=0

make VERBOSE=1 -j "${CPU_COUNT}"

make install
