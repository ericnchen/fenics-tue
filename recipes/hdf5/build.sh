#!/bin/bash

export LIBRARY_PATH="${PREFIX}/lib"

./configure                                            \
  CC="${PREFIX}/bin/mpicc"                             \
  CFLAGS="-fPIC"                                       \
  CXX="${PREFIX}/bin/mpicxx"                           \
  CXXFLAGS="-fPIC"                                     \
  --prefix="${PREFIX}"                                 \
  --disable-debug                                      \
  --enable-production                                  \
  --enable-cxx                                         \
  --disable-fortran                                    \
  --disable-fortran2003                                \
  --disable-hl                                         \
  --enable-parallel                                    \
  --disable-static                                     \
  --enable-shared                                      \
  --enable-threadsafe                                  \
  --enable-unsupported                                 \
  --with-pthread=yes                                   \
  --with-default-plugindir="${PREFIX}/lib/hdf5/plugin" \
  --with-zlib="${PREFIX}"

make -j 4 install

rm -rf "${PREFIX}/share/hdf5_examples"
