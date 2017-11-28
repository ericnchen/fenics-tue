#!/usr/bin/env bash

# Added stuff for the TUe proxy.
PROXY_SERVER="proxy.wfw.wtb.tue.nl"

check_internet() {
  # Check if internet is available.
  #
  # Exit Codes
  #   0 - internet is available
  #   * - internet is not available

  wget -q --tries=2 --timeout=2 --spider https://google.com
}
# ---

# Modified build script from the existing conda-forge repository.
# Mostly untouched.

if [[ "$(uname)" == "Darwin" ]]; then
  export MACOSX_DEPLOYMENT_TARGET=10.9
  export CXXFLAGS="-std=c++11 -stdlib=libc++ $CXXFLAGS"
  export LDFLAGS="-Wl,-rpath,$PREFIX/lib $LDFLAGS"
fi

# Components (ffc, etc.)
#check_internet
#if [ "${?}" != "0" ]; then
#  pip install --proxy "https://${PROXY_SERVER}:443" --no-deps --no-binary :all: -r "${RECIPE_DIR}/component-requirements.txt"
#else
#  pip install --no-deps --no-binary :all: -r "${RECIPE_DIR}/component-requirements.txt"
#fi

# DOLFIN

# Tarball includes cached swig output built with Python 3.
# Re-generate it with correct Python.
#$PYTHON cmake/scripts/generate-swig-interface.py

rm -rf build
mkdir build
cd build

export LIBRARY_PATH=$PREFIX/lib
export INCLUDE_PATH=$PREFIX/include

#export PETSC_DIR=$PREFIX
#export SLEPC_DIR=$PREFIX
#export BLAS_DIR=$LIBRARY_PATH

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

make VERBOSE=1 -j 2
make install

# Don't include demos in installed package
rm -rf $PREFIX/share/dolfin/demo

# remove paths for unused deps in cmake files
# these paths may not exist on targets and aren't needed,
# but cmake will die with 'no rule to make /Applications/...libclang_rt.osx.a'

if [[ "$(uname)" == "Darwin" ]]; then
    find $PREFIX/share/dolfin -name '*.cmake' -print -exec sh -c "sed -E -i ''  's@/Applications/Xcode.app[^;]*(.dylib|.framework|.a);@@g' {}" \;
else
    find $PREFIX/share/dolfin -name '*.cmake' -print -exec sh -c "sed -E -i''  's@/usr/lib(64)?/[^;]*(.so|.a);@@g' {}" \;
fi


