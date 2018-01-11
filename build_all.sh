#!/bin/bash
#
# Build all conda packages in the appropriate order.

set -e

#bash conda_build tue

# SCOTCH and PT-SCOTCH have no dependencies.
conda build recipes/scotch

# OpenBLAS has no dependencies.
conda build recipes/openblas

#bash conda_build mumps
#bash conda_build petsc

#bash conda_build hdf5

#bash conda_build fenics-components

#bash conda_build dolfin
#bash conda_build mshr

#bash conda_build fenics

conda build purge
