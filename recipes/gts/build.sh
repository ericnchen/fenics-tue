#!/bin/bash
#
# Build the GTS library.

./configure --prefix="${PREFIX}"

make
make install
make installcheck
