#!/usr/bin/env bash
set -e

TOKEN=$1

build() {
  docker run -v $(pwd)/recipes:/home/builder/recipes --rm fenics-tue:builder /anaconda/bin/conda build -c tue --skip-existing --token $TOKEN $1
}

build recipes/openmpi
build recipes/blacs
build recipes/hdf5
build recipes/hypre
build recipes/scotch
build recipes/scalapack
build recipes/mumps
build recipes/petsc
    build recipes/fenics-dijitso
    build recipes/fenics-ufl
    build recipes/fenics-instant
    build recipes/fenics-fiat
    build recipes/fenics-ffc
    build recipes/fenics-dolfin
        build recipes/fenics-mshr
build recipes/fenics
