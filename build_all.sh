#!/bin/bash
#
# Build all conda packages in the appropriate order.

set -e

# fenics-dijitso

# openmpi

# openmpi -> blacs
# openmpi -> hdf5
# openmpi -> hypre
# openmpi -> scotch

# openmpi -> blacs -> scalapack

# openmpi -> [blacs, blacs, scotch, scalapack] -> mumps

# openmpi -> [blacs, scalapack, scotch, mumps, hdf5, hypre, suitesparse] -> petsc

# ---

# fenics-ufl
# fenics-instant
# fenics-fiat
# fenics-ffc

#bash conda_build dolfin
#bash conda_build mshr
#bash conda_build fenics
# openmpi -> XXX -> suitesparse
