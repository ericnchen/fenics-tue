#!/bin/bash

export LIBRARY_PATH="${PREFIX}/lib"

./configure --prefix="${PREFIX}" \
            --enable-linux-lfs \
            --with-zlib="${PREFIX}" \
            --with-pthread=yes  \
            --enable-cxx \
            --disable-fortran \
            --disable-fortran2003 \
            --with-default-plugindir="${PREFIX}/lib/hdf5/plugin" \
            --enable-threadsafe \
            --enable-production \
            --enable-unsupported \
            --with-ssl \
            --disable-debug \
            --disable-hl \
            --disable-static \
            --enable-parallel \
            --enable-shared \
            CC="${PREFIX}/bin/mpicc" CXX="${PREFIX}/bin/mpicxx" \
            CFLAGS="-fPIC" CXXFLAGS="-fPIC"

make -j 4
make install -j 4

rm -rf $PREFIX/share/hdf5_examples
