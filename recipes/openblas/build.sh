#!/usr/bin/env bash

unset CFLAGS
unset LDFLAGS
cp "${RECIPE_DIR}/Makefile.rule" Makefile.rule
make -j "${CPU_COUNT}"
make PREFIX="${PREFIX}" install
