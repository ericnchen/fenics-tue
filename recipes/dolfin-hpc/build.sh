#!/bin/bash
#
# Build the DOFLIN-HPC library.

#export PETSC_DIR=$PREFIX

bash regen.sh

./configure              \
  --prefix="${PREFIX}"   \
  --disable-progress-bar \
  --enable-mpi           \
  --enable-mpi-io        \
  --with-gts             \
  --with-parmetis        \
  --with-petsc="${PREFIX}"

# "$(pkg-config --variable prefix PETSc)"
# PETSC_DIR should be /usr/lib/petscdir/3.7.3/x86_64-linux-gnu-real but the above does it automatically.
#make
#make check
#make install