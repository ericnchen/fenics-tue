#!/usr/bin/env bash
set -e

export PETSC_DIR="${PREFIX}"
export PKG_CONFIG_PATH="${PREFIX}/lib/pkgconfig"
export LD_LIBRARY_PATH="${PREFIX}/lib"
export LIBRARY_PATH=$PREFIX/lib
export INCLUDE_PATH=$PREFIX/include

rm -rf build && mkdir build

cd build

cmake .. \
  -DCMAKE_C_COMPILER=mpicc \
  -DCMAKE_CXX_COMPILER=mpicxx \
  -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
  -DDOLFIN_ENABLE_GTEST=0 \
  -DDOLFIN_ENABLE_OPENMP=0 \
  -DDOLFIN_ENABLE_PARMETIS=0 \
  -DDOLFIN_ENABLE_TRILINOS=0 \
  -DDOLFIN_ENABLE_VTK=0 \
  -DDOLFIN_USE_PYTHON3="${PY3K}" \
  -DPYTHON_EXECUTABLE="${PYTHON}" \
  -DCMAKE_C_FLAGS="${CFLAGS}" \
  -DCMAKE_C_FLAGS_RELEASE="${CFLAGS}" \
  -DCMAKE_CXX_FLAGS="${CXXFLAGS}" \
  -DCMAKE_CXX_FLAGS_RELEASE="${CXXFLAGS}" \
  -DCMAKE_INSTALL_LIBDIR=$PREFIX/lib \
  -DCMAKE_INCLUDE_PATH=$INCLUDE_PATH \
  -DCMAKE_LIBRARY_PATH=$LIBRARY_PATH \
  -DCMAKE_BUILD_TYPE="release"

make VERBOSE=1 -j "${CPU_COUNT}"

make install

# Don't include demos in installed package.
rm -rf "${PREFIX}/share/dolfin/demo"

# remove paths for unused deps in cmake files
# these paths may not exist on targets and aren't needed,
# but cmake will die with 'no rule to make /Applications/...libclang_rt.osx.a'

if [[ "$(uname)" == "Darwin" ]]; then
    find $PREFIX/share/dolfin -name '*.cmake' -print -exec sh -c "sed -E -i ''  's@/Applications/Xcode.app[^;]*(.dylib|.framework|.a);@@g' {}" \;
else
    find $PREFIX/share/dolfin -name '*.cmake' -print -exec sh -c "sed -E -i''  's@/usr/lib(64)?/[^;]*(.so|.a);@@g' {}" \;
fi

# install Python bindings
cd ../python
$PYTHON -m pip install -v --no-deps .
cd test
$PYTHON -c 'from dolfin import *; info(parameters["form_compiler"], True)'
