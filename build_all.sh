#!/bin/bash
#
# Build all conda packages in the appropriate order.

set -e

# python -> fenics-dijitso
# python -> fenics-ufl
# python -> fenics-instant
# python -> fenics-fiat

# python -> [fenics-ufl, fenics-fiat] -> fenics-ffc
# python -> [fenics-dijitso, fenics-ufl, fenics-instant, fenics-fiat, fenics-ffc] -> fenics-dolfin

# openmpi

# openmpi -> blacs
# openmpi -> hdf5
# openmpi -> hypre
# openmpi -> scotch

# openmpi -> blacs -> scalapack

# openmpi -> [blacs, blacs, scotch, scalapack] -> mumps

# openmpi -> [blacs, scalapack, scotch, mumps, hdf5, hypre, suitesparse] -> petsc

# ---

#bash conda_build mshr
# openmpi -> XXX -> suitesparse
