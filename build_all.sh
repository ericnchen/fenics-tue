#!/bin/bash
#
# Build all conda packages in the appropriate order.

set -e

# openmpi -> blacs
# openmpi -> hdf5
# openmpi -> hypre
# openmpi -> scotch

# openmpi -> blacs -> scalapack

# openmpi -> [blacs, blacs, scotch, scalapack] -> mumps

# ---

# openmpi -> XXX -> suitesparse

# openmpi -> [blacs, scalapack, scotch, mumps, hdf5, hypre, suitesparse] -> petsc

#bash conda_build fenics-components

#bash conda_build dolfin
#bash conda_build mshr

#bash conda_build fenics
