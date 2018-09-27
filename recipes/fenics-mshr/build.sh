#!/usr/bin/env bash
set -e

rm -rf build && mkdir build

cd build

cmake .. \
  -DCMAKE_C_COMPILER=mpicc \
  -DCMAKE_CXX_COMPILER=mpicxx \
  -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
  -DENABLE_TESTS=1 \
  -DMSHR_ENABLE_VTK=0 \
  -DCMAKE_C_FLAGS="${CFLAGS}" \
  -DCMAKE_C_FLAGS_RELEASE="${CFLAGS}" \
  -DCMAKE_CXX_FLAGS="${CXXFLAGS}" \
  -DCMAKE_CXX_FLAGS_RELEASE="${CXXFLAGS}" \
  -DCMAKE_BUILD_TYPE="Release"

make VERBOSE=1 -j "${CPU_COUNT}"

make install

cd ../python
$PYTHON -m pip install -v --no-deps --ignore-installed --no-binary :all: .
