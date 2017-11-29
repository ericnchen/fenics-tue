#!/bin/bash

# DOLFIN

# Tarball includes cached swig output built with Python 3.
# Re-generate it with correct Python.
#$PYTHON cmake/scripts/generate-swig-interface.py

rm -rf build
mkdir build
cd build

export LIBRARY_PATH=$PREFIX/lib
export INCLUDE_PATH=$PREFIX/include

export PETSC_DIR=$PREFIX
export SLEPC_DIR=$PREFIX
export BLAS_DIR=$LIBRARY_PATH

if [ "$PY3K" = "1" ]; then
    export USE_PYTHON3=on
else
    export USE_PYTHON3=off
fi

cmake .. \
  -DDOLFIN_ENABLE_OPENMP=off \
  -DDOLFIN_ENABLE_MPI=on \
  -DDOLFIN_ENABLE_PETSC=on \
  -DDOLFIN_ENABLE_PETSC4PY=on \
  -DDOLFIN_ENABLE_SCOTCH=on \
  -DDOLFIN_ENABLE_HDF5=on \
  -DDOLFIN_ENABLE_VTK=off \
  -DDOLFIN_USE_PYTHON3=$USE_PYTHON3 \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_INCLUDE_PATH=$INCLUDE_PATH \
  -DCMAKE_LIBRARY_PATH=$LIBRARY_PATH \
  -DPYTHON_EXECUTABLE=$PYTHON || (cat CMakeFiles/CMakeError.log && exit 1)

#  -DDOLFIN_SKIP_BUILD_TESTS=1 \
#  -DCMAKE_C_COMPILER="${PREFIX}/bin/mpicc" \
#  -DCMAKE_CXX_COMPILER="${PREFIX}/bin/mpicxx" \

make VERBOSE=1 -j 4
make install

# Don't include demos in installed package
rm -rf $PREFIX/share/dolfin/demo

# remove paths for unused deps in cmake files
# these paths may not exist on targets and aren't needed,
# but cmake will die with 'no rule to make /Applications/...libclang_rt.osx.a'
find $PREFIX/share/dolfin -name '*.cmake' -print -exec sh -c "sed -E -i''  's@/usr/lib(64)?/[^;]*(.so|.a);@@g' {}" \;
