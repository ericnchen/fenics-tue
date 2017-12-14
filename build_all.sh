#!/bin/bash
#
# Build all conda packages in the appropriate order.

bash conda_build tue

bash conda_build mumps
bash conda_build petsc

bash conda_build hdf5

bash conda_build fenics-components

bash conda_build dolfin
bash conda_build mshr

bash conda_build fenics

bash conda_build purge
