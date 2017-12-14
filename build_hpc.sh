#!/bin/bash
#
# Build all conda packages in the appropriate order for fenics-hpc.
# TODO This file is currently just a skeleton/for testing purposes.

#bash conda_build tue  # leave in; might change to tue-hpc?

#bash conda_build petsc

#bash conda_build gts

bash conda_build fenics-components 2008.1.0

#bash conda_build dolfin

#bash conda_build fenics

#bash conda_build purge
