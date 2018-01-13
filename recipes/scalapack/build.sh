#!/usr/bin/env bash

set -e

cp "${RECIPE_DIR}/Makefile" Makefile
cp "${RECIPE_DIR}/SLmake.inc.example" SLmake.inc
#make -j "${CPU_COUNT}" lib
env