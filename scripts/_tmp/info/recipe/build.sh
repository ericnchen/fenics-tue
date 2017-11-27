#!/bin/bash

if [ `uname -m` == ppc64le ]; then
    B="--build=ppc64le-linux"
fi

if [ `uname` == Linux ]; then
    export CFLAGS="$CFLAGS"
    export LDFLAGS="$LDFLAGS"
fi

./configure $B --prefix=$PREFIX --disable-static \
    --enable-linux-lfs --with-zlib --with-ssl \
    --enable-threadsafe --with-pthread=yes \
    --enable-production --enable-cxx \
    --enable-unsupported
make
make install

rm -rf $PREFIX/share/hdf5_examples
