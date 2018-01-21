#!/bin/bash
#
# Build all conda packages in the appropriate order.

set -e

# openmpi -> blacs
# openmpi -> blacs -> scalapack

# ---
# openmpi -> scotch

# openmpi -> [blacs, scalapack, scotch] -> mumps
# openmpi -> hdf5
# openmpi -> hypre

# ---

# openmpi -> XXX -> suitesparse

# openmpi -> [blacs, scalapack, scotch, mumps, hdf5, hypre, suitesparse] -> petsc

#bash conda_build fenics-components

#bash conda_build dolfin
#bash conda_build mshr

#bash conda_build fenics
