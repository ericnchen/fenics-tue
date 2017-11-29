#!/usr/bin/env bash

WORKDIR="$(pwd)"
INSTALLDIR="${HOME}/.local/opt/fenics-mkl-2017.1.0"

if [[ ! -d "${INSTALLDIR}" ]]; then
    mkdir -p "${INSTALLDIR}"
fi

module purge
module load /share/apps/modules/gcc49 /share/apps/modules/openmpi2gcc49
module load use.own python/mkl

install_boost () {
    # needs 1.50 minimum
    tar -C /tmp -xjf "${WORKDIR}/external_downloads/boost_1_56_0.tar.bz2"
    cd /tmp/boost_1_56_0
    ./bootstrap.sh \
        --prefix="${INSTALLDIR}/boost" \
        --with-icu \
        --with-python="${CONDA_PREFIX}/bin/python" \
        --with-python-root="${CONDA_PREFIX}:${CONDA_PREFIX}/include/python3.5m" \
        --with-libraries=filesystem,iostreams,program_options,regex,timer
    ./b2 -q -j 4 \
        cxxflags="-O3 -fPIC" \
        include="${CONDA_PREFIX}/include" \
        link=shared \
        linkflags="-L${CONDA_PREFIX}/lib ${LDFLAGS}" \
        python="3.5" \
        runtime-link=shared \
        threading=multi \
        variant=release \
        install
    rm -rf /tmp/boost_1_56_0
}

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
    tar -C /tmp -xzf "${WORKDIR}/external_downloads/scotch_6.0.4.tar.gz"
    cp "${WORKDIR}/external_downloads/Makefile.inc.scotch" /tmp/scotch_6.0.4/src/Makefile.inc
    cd /tmp/scotch_6.0.4/src
    make scotch ptscotch esmumps ptesmumps
    cd /tmp/scotch_6.0.4
    mkdir -p "${INSTALLDIR}/scotch/bin" "${INSTALLDIR}/scotch/include" "${INSTALLDIR}/scotch/lib"
    cp bin/* "${INSTALLDIR}/scotch/bin/"
    cp include/* "${INSTALLDIR}/scotch/include/"
    cp lib/* "${INSTALLDIR}/scotch/lib/"
    rm -rf /tmp/scotch_6.0.4
}

install_mumps () {
    tar -C /tmp -xjf "${WORKDIR}/external_downloads/release-5.1.1.tar.bz2"
    cd /tmp/petsc-pkg-mumps-*
    mkdir lib
    cp "${WORKDIR}/external_downloads/Makefile.inc.mumps" Makefile.inc
    make -j 4
    mkdir -p "${INSTALLDIR}/mumps/include" "${INSTALLDIR}/mumps/lib"
    cp include/* "${INSTALLDIR}/mumps/include/"
    cp lib/* "${INSTALLDIR}/mumps/lib/"
    rm -rf /tmp/petsc-pkg-mumps-*
}

install_petsc () {
    tar -C /tmp -xzf "${WORKDIR}/external_downloads/petsc-lite-3.7.7.tar.gz"
    cd /tmp/petsc-3.7.7
    /usr/bin/python configure \
        CFLAGS="-O3 -fPIC" CXXFLAGS="-O3 -fPIC" FFLAGS="-O3 -fPIC" \
        --prefix="${INSTALLDIR}/petsc" \
        --with-blas-lapack-include="${CONDA_PREFIX}/include" \
        --with-blas-lapack-lib="-L${CONDA_PREFIX}/lib -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl" \
        --with-debugging=0 \
        --with-hdf5-include="${INSTALLDIR}/hdf5/include" \
        --with-hdf5-lib="-L${INSTALLDIR}/hdf5/lib -lhdf5" \
        --with-hypre-include="${INSTALLDIR}/hypre/include" \
        --with-hypre-lib="-L${INSTALLDIR}/hypre/lib -lHYPRE" \
        --with-log=0 \
        --with-mpi=1 \
        --with-mumps-include="${INSTALLDIR}/mumps/include" \
        --with-mumps-lib="-L${INSTALLDIR}/mumps/lib -ldmumps -lmumps_common -lpord" \
        --with-pic=1 \
        --with-pthread \
        --with-ptscotch-include="${INSTALLDIR}/scotch/include" \
        --with-ptscotch-lib="-L${INSTALLDIR}/scotch/lib -lptesmumps -lptscotch -lscotcherr -lscotch -L${CONDA_PREFIX}/lib -lz" \
        --with-scalapack-lib="-L${CONDA_PREFIX}/lib -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl -lmkl_blacs_openmpi_lp64 -lmkl_scalapack_lp64" \
        --with-ssl=0 \
        --with-valgrind=0 \
        --with-x=0
    make all
    make install
    rm -rf /tmp/petsc-3.7.7
}

install_eigen () {
    mkdir /tmp/eigen3
    tar -C /tmp/eigen3 -xjf "${WORKDIR}/external_downloads/3.2.0.tar.bz2"
    mkdir -p "${INSTALLDIR}/eigen/include"
    cd /tmp/eigen3/eigen-eigen-*
    mv Eigen "${INSTALLDIR}/eigen/include/."
    mv unsupported "${INSTALLDIR}/eigen/include/."
    rm -rf /tmp/eigen3
}

install_swig () {
    tar -C /tmp -xzf "${WORKDIR}/external_downloads/swig-3.0.5.tar.gz"
    cd /tmp/swig-3.0.5
    ./configure \
        CFLAGS="-O3 -fPIC" CXXFLAGS="-O3 -fPIC" \
        --prefix="${INSTALLDIR}/swig" \
        --with-boost="${INSTALLDIR}/boost" \
        --without-go \
        --without-java \
        --without-perl5 \
        --without-tcl
    make -j 4
    make install
    rm -rf /tmp/swig-3.0.5
}
