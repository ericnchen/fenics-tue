#!/bin/bash
#
# Build all conda packages in the appropriate order.

set -e

#bash conda_build tue

# These packages have no dependencies to other self-compiled packages.
conda build recipes/blacs
conda build recipes/scotch
conda build recipes/openblas
# These packages have no dependencies to other self-compiled packages.

#bash conda_build mumps
#bash conda_build petsc

#bash conda_build hdf5

#bash conda_build fenics-components

#bash conda_build dolfin
#bash conda_build mshr

#bash conda_build fenics

conda build purge
