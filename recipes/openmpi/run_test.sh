#!/usr/bin/env bash
set -e

ln -s "${CC}"  "${CONDA_PREFIX}/bin/gcc"
ln -s "${FC}"  "${CONDA_PREFIX}/bin/gfortran"
ln -s "${CXX}" "${CONDA_PREFIX}/bin/g++"

cd examples

make mpi

mpirun -np 4 hello_cxx
mpirun -np 4 hello_mpifh
mpirun -np 4 hello_usempi
mpirun -np 4 hello_usempif08
mpirun -np 4 ring_cxx
mpirun -np 4 ring_mpifh
mpirun -np 4 ring_usempi
mpirun -np 4 ring_usempif08
