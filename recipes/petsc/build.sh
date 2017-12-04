#!/bin/bash

export PETSC_DIR=$SRC_DIR
export PETSC_ARCH=arch-conda-c-opt

unset CC
unset CXX
if [[ $(uname) == Linux ]]; then
    export LDFLAGS="-pthread $LDFLAGS"
fi

$PYTHON ./configure \
  CPPFLAGS="${CPPFLAGS}" LDFLAGS="${LDFLAGS}" \
  CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" FFLAGS="${FFLAGS}" \
  --COPTFLAGS=-O3 --CXXOPTFLAGS=-O3 --FOPTFLAGS=-O3 \
  --with-debugging=0 \
  --with-blas-lapack-lib=libopenblas${SHLIB_EXT} \
  --with-hwloc=0 \
  --with-mpi=1 \
  --with-pthread=1 \
  --with-ptscotch=1 \
  --with-ssl=0 \
  --with-suitesparse=1 \
  --with-x=0 \
  --with-hypre=1 \
  --with-mumps=1 \
  --with-scalapack=1 \
  --prefix=$PREFIX

sedinplace() { [[ $(uname) == Darwin ]] && sed -i "" $@ || sed -i"" $@; }
for path in $PETSC_DIR $PREFIX; do
    sedinplace s%$path%\${PETSC_DIR}%g $PETSC_ARCH/include/petsc*.h
done

make

# FIXME: Workaround mpiexec setting O_NONBLOCK in std{in|out|err}
# See https://github.com/conda-forge/conda-smithy/pull/337
# See https://github.com/pmodels/mpich/pull/2755
make check MPIEXEC="${RECIPE_DIR}/mpiexec.sh"

make install

rm -fr $PREFIX/bin && mkdir $PREFIX/bin
rm -fr $PREFIX/share && mkdir $PREFIX/share
rm -fr $PREFIX/lib/lib$PKG_NAME.*.dylib.dSYM
rm -f  $PREFIX/lib/$PKG_NAME/conf/.DIR
rm -f  $PREFIX/lib/$PKG_NAME/conf/mpitest.c
rm -f  $PREFIX/lib/$PKG_NAME/conf/files
rm -f  $PREFIX/lib/$PKG_NAME/conf/testfiles
rm -f  $PREFIX/lib/$PKG_NAME/conf/*.py
rm -f  $PREFIX/lib/$PKG_NAME/conf/*.log
rm -f  $PREFIX/lib/$PKG_NAME/conf/RDict.db
rm -f  $PREFIX/lib/$PKG_NAME/conf/*BuildInternal.cmake
find   $PREFIX/include -name '*.html' -delete
