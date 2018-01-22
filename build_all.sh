#!/bin/bash
#
# Build all conda packages in the appropriate order.

set -e

# python -> fenics-dijitso
# python -> fenics-ufl
# python -> fenics-instant
# python -> fenics-fiat

# python -> [fenics-ufl, fenics-fiat] -> fenics-ffc

# openmpi

# openmpi -> blacs
# openmpi -> hdf5
# openmpi -> hypre
# openmpi -> scotch

# openmpi -> blacs -> scalapack

# openmpi -> [blacs, blacs, scotch, scalapack] -> mumps

# openmpi -> [blacs, scalapack, scotch, mumps, hdf5, hypre, suitesparse] -> petsc

# ---

#bash conda_build dolfin
#bash conda_build mshr
#bash conda_build fenics
# openmpi -> XXX -> suitesparse
