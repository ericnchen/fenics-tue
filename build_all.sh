#!/bin/bash
#
# Build all conda packages in the appropriate order.

bash conda_build.sh mumps
bash conda_build.sh petsc

bash conda_build.sh hdf5

bash conda_build.sh fenics-python-components

bash conda_build.sh dolfin
bash conda_build.sh mshr

bash conda_build.sh fenics

bash conda_build.sh purge
