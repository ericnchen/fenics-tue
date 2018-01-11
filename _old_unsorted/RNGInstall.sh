#!/usr/bin/env bash

WORKDIR="$(pwd)"
INSTALLDIR="${HOME}/.local/opt/fenics-mkl-2017.1.0"

if [[ ! -d "${INSTALLDIR}" ]]; then
    mkdir -p "${INSTALLDIR}"
fi

module purge
module load /share/apps/modules/gcc49 /share/apps/modules/openmpi2gcc49
module load use.own python/mkl

install_hypre () {
    tar -C /tmp -xzf "${WORKDIR}/external_downloads/hypre-2.11.2.tar.gz"
    cd /tmp/hypre-2.11.2/src
    ./configure \
        CFLAGS="-O3" CXXFLAGS="-O3" \
        --disable-debug \
        --disable-fortran \
        --enable-shared \
        --prefix="${INSTALLDIR}/hypre" \
        --with-blas-lib="-L${CONDA_PREFIX}/lib -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl" \
        --with-lapack-lib="-L${CONDA_PREFIX}/lib -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl" \
        --without-fei \
        --without-superlu
    make -j 4
    make install
    rm -rf /tmp/hypre-2.11.2
}

install_scotch () {
    make scotch ptscotch esmumps ptesmumps
}

install_petsc () {
        CFLAGS="-O3 -fPIC" CXXFLAGS="-O3 -fPIC" FFLAGS="-O3 -fPIC" \
        --with-blas-lapack-include="${CONDA_PREFIX}/include" \
        --with-blas-lapack-lib="-L${CONDA_PREFIX}/lib -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl" \
        --with-hdf5-include="${INSTALLDIR}/hdf5/include" \
        --with-hdf5-lib="-L${INSTALLDIR}/hdf5/lib -lhdf5" \
        --with-hypre-include="${INSTALLDIR}/hypre/include" \
        --with-hypre-lib="-L${INSTALLDIR}/hypre/lib -lHYPRE" \
        --with-log=0 \
        --with-mumps-include="${INSTALLDIR}/mumps/include" \
        --with-mumps-lib="-L${INSTALLDIR}/mumps/lib -ldmumps -lmumps_common -lpord" \
        --with-pic=1 \
        --with-ptscotch-include="${INSTALLDIR}/scotch/include" \
        --with-ptscotch-lib="-L${INSTALLDIR}/scotch/lib -lptesmumps -lptscotch -lscotcherr -lscotch -L${CONDA_PREFIX}/lib -lz" \
        --with-scalapack-lib="-L${CONDA_PREFIX}/lib -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl -lmkl_blacs_openmpi_lp64 -lmkl_scalapack_lp64" \
        --with-valgrind=0 \
}
