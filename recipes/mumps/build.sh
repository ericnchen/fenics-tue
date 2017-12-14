#!/bin/bash

cp "${RECIPE_DIR}/Makefile.inc.PAR" ./Makefile.inc

make -j 4 all

cp lib/*.a     "${PREFIX}/lib"
cp include/*.h "${PREFIX}/include"
