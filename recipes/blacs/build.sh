#!/usr/bin/env bash

cp "${RECIPE_DIR}/Bmake.MPI-LINUX" Bmake.inc
cp "${RECIPE_DIR}/Bmake.MPI-LINUX" "${PREFIX}/Bmake.inc"
make mpi
