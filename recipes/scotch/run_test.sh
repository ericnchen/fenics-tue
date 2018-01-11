#!/usr/bin/env bash

cd src
cp "${RECIPE_DIR}/Makefile.inc.x86-64_pc_linux2" Makefile.inc
make check
make ptcheck
