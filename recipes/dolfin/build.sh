#!/bin/bash
#
# Build the DOFLIN library.

# Tarball includes cached swig output built with Python 3.
# Re-generate it with correct Python.
"${PYTHON}" cmake/scripts/generate-swig-interface.py

rm -rf build && mkdir build && cd build

#export LIBRARY_PATH=$PREFIX/lib
#export INCLUDE_PATH=$PREFIX/include

#export PETSC_DIR=$PREFIX
#export SLEPC_DIR=$PREFIX
#export BLAS_DIR=$LIBRARY_PATH

cmake ..                             \
  -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
  -DDOLFIN_ENABLE_GTEST=0            \
  -DDOLFIN_ENABLE_OPENMP=0           \
  -DDOLFIN_ENABLE_PARMETIS=0         \
  -DDOLFIN_ENABLE_TRILINOS=0         \
  -DDOLFIN_ENABLE_VTK=0              \
  -DDOLFIN_USE_PYTHON3="${PY3K}"     \
  -DPYTHON_EXECUTABLE="${PYTHON}"

make -j 4 install

# Don't include demos in installed package
rm -rf $PREFIX/share/dolfin/demo

# remove paths for unused deps in cmake files
# these paths may not exist on targets and aren't needed,
# but cmake will die with 'no rule to make /Applications/...libclang_rt.osx.a'
find $PREFIX/share/dolfin -name '*.cmake' -print -exec sh -c "sed -E -i''  's@/usr/lib(64)?/[^;]*(.so|.a);@@g' {}" \;
