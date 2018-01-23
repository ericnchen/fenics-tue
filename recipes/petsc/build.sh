#!/usr/bin/env bash
set -e

source "${RECIPE_DIR}/fix-environment.sh"

unset FC
unset F77
unset CC
unset CXX

export PETSC_DIR="${SRC_DIR}"
export PETSC_ARCH='arch-conda-c-opt'

export LD_LIBRARY_PATH="${PREFIX}/lib"

./configure \
  --prefix="${PREFIX}" \
  --with-clib-autodetect=0 \
  --with-cxxlib-autodetect=0 \
  --with-fortranlib-autodetect=0 \
  --with-debugging=0 \
  --CC=mpicc \
  --CXX=mpicxx \
  --FC=mpifort \
  --F77=mpifort \
  --AR="${AR}" \
  --CPP="${CPP}" \
  --CPPFLAGS="${CPPFLAGS}" \
  --FFLAGS="${FFLAGS}" \
  --FCFLAGS="${FCFLAGS}" \
  --CFLAGS="${CFLAGS}" \
  --CXXFLAGS="${CXXFLAGS}" \
  --LDFLAGS="${LDFLAGS} -pthread" \
  --with-blas-lapack-lib="-lopenblas" \
  --with-ptscotch-include="${PREFIX}/include" \
  --with-ptscotch-lib=[-lptesmumps,-lptscotch,-lscotch,-lscotcherr] \
  --with-mpi-include="${PREFIX}/include" \
  --with-mpi-lib="-lmpi" \
  --with-hypre=1 \
  --with-scalapack-include="${PREFIX}/include" \
  --with-scalapack-lib=[-lscalapack,-lblacs,-lblacs_F77init,-lblacs,-lgfortran] \
  --with-mumps-include="${PREFIX}/include" \
  --with-mumps-lib=[-ldmumps,-lmumps_common,-lptesmumps,-lptscotch,-lscotch,-lscotcherr,-lpord,-lscalapack,-lblacs,-lblacs_F77init,-lblacs,-lmpi_mpifh,-lopenblas,-lpthread] \
  --with-x=0 \
  --with-valgrind=0 \
  --with-hwloc=0 \
  --with-ssl=0 \
  --with-pthread=1

sedinplace() { [[ $(uname) == Darwin ]] && sed -i "" $@ || sed -i"" $@; }
for path in $PETSC_DIR $PREFIX; do
    sedinplace s%$path%\${PETSC_DIR}%g $PETSC_ARCH/include/petsc*.h
done

# At some point I should add this library back in.
# At the moment, I leave it out because it seems to require METIS.
#  --with-suitesparse=1

make MAKE_NP=4

make check
#make streams  # takes too long

make install
make test

rm -rf "${PREFIX}/bin"
rm -rf "${PREFIX}/share"

rm -f "${PREFIX}/lib/petsc/conf/*.log"
rm -f "${PREFIX}/lib/petsc/conf/files"
rm -f "${PREFIX}/lib/petsc/conf/testfiles"
rm -f "${PREFIX}/lib/petsc/conf/RDict.db"
rm -f "${PREFIX}/lib/petsc/conf/PETScBuildInternal.cmake"
rm -f "${PREFIX}/lib/petsc/conf/mpitest.c"
rm -f "${PREFIX}/lib/petsc/conf/uninstall.py"
rm -f "${PREFIX}/lib/petsc/conf/test"
rm -f "${PREFIX}/lib/petsc/conf/.DIR"
