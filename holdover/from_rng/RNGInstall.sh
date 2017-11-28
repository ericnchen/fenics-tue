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

install_hdf5 () {
    tar -C /tmp -xjf "${WORKDIR}/external_downloads/hdf5-1.8.19.tar.bz2"
    cd /tmp/hdf5-1.8.19
    ./configure \
        CC=mpicc CXX=mpicxx \
        CFLAGS="-O3 -fPIC" CXXFLAGS="-O3 -fPIC" \
        --disable-debug \
        --disable-fortran \
        --disable-hl \
        --disable-static \
        --enable-cxx \
        --enable-linux-lfs \
        --enable-parallel \
        --enable-production \
        --enable-shared \
        --enable-threadsafe \
        --enable-unsupported \
        --prefix="${INSTALLDIR}/hdf5" \
        --with-pthread \
        --with-zlib="${CONDA_PREFIX}/lib"
    make -j 4
    make install
    rm -rf /tmp/hdf5-1.8.19
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

install_fenics_python () {
    pip install --no-cache-dir --no-index "${WORKDIR}/external_downloads/fiat-2017.1.0.tar.bz2"
    pip install --no-cache-dir --no-index "${WORKDIR}/external_downloads/ufl-2017.1.0.tar.bz2"
    pip install --no-cache-dir --no-index "${WORKDIR}/external_downloads/dijitso-2017.1.0.tar.bz2"
    pip install --no-cache-dir --no-index "${WORKDIR}/external_downloads/ffc-2017.1.0.tar.bz2"
    pip install --no-cache-dir --no-index "${WORKDIR}/external_downloads/instant-2017.1.0.tar.bz2"
}

install_dolfin () {
    tar -C /tmp -xzf "${WORKDIR}/external_downloads/dolfin-2017.1.0.tar.gz"
    mkdir /tmp/dolfin-2017.1.0/build
    cd /tmp/dolfin-2017.1.0/build
    export LD_LIBRARY_PATH="${CONDA_PREFIX}/lib:${LD_LIBRARY_PATH}"
    export PETSC_DIR="${INSTALLDIR}/petsc"
    export PKG_CONFIG_PATH="${PETSC_DIR}/lib/pkgconfig:${PKG_CONFIG_PATH}"
    cmake .. \
        -DBOOST_ROOT="${INSTALLDIR}/boost" \
        -DCMAKE_C_COMPILER=mpicc \
        -DCMAKE_CXX_COMPILER=mpicxx \
        -DCMAKE_INSTALL_PREFIX="${INSTALLDIR}/dolfin" \
        -DDOLFIN_ENABLE_CHOLMOD=0 \
        -DDOLFIN_ENABLE_DOCS=0 \
        -DDOLFIN_ENABLE_GTEST=0 \
        -DDOLFIN_ENABLE_PARMETIS=0 \
        -DDOLFIN_ENABLE_PETSC4PY=0 \
        -DDOLFIN_ENABLE_SLEPC=0 \
        -DDOLFIN_ENABLE_SLEPC4PY=0 \
        -DDOLFIN_ENABLE_SPHINX=0 \
        -DDOLFIN_ENABLE_TRILINOS=0 \
        -DDOLFIN_ENABLE_UMFPACK=0 \
        -DDOLFIN_ENABLE_VTK=0 \
        -DDOLFIN_SKIP_BUILD_TESTS=1 \
        -DEIGEN3_INCLUDE_DIR="${INSTALLDIR}/eigen/include" \
        -DHDF5_ROOT="${INSTALLDIR}/hdf5" \
        -DSCOTCH_DIR="${INSTALLDIR}/scotch" \
        -DSWIG_EXECUTABLE="${INSTALLDIR}/swig/bin/swig" \
        -DZLIB_ROOT="${CONDA_PREFIX}"
    make -j 4 all
    make install
    rm -rf /tmp/dolfin-2017.1.0
}

install_mshr () {
    mkdir /tmp/mshr
    tar -C /tmp/mshr -xjf "${WORKDIR}/external_downloads/mshr-2017.1.0.tar.bz2"
    cd /tmp/mshr/fenics-project-mshr-*
    mkdir build
    cd build
    source "${INSTALLDIR}/dolfin/share/dolfin/dolfin.conf"
    export LD_LIBRARY_PATH="${CONDA_PREFIX}/lib:${LD_LIBRARY_PATH}"
    export PETSC_DIR="${INSTALLDIR}/petsc"
    export PKG_CONFIG_PATH="${PETSC_DIR}/lib/pkgconfig:${PKG_CONFIG_PATH}"
    cmake .. \
        -DBOOST_ROOT="${INSTALLDIR}/boost" \
        -DCMAKE_BUILD_TYPE="Release" \
        -DCMAKE_C_COMPILER=mpicc \
        -DCMAKE_CXX_COMPILER=mpicxx \
        -DCMAKE_INSTALL_PREFIX="${INSTALLDIR}/mshr" \
        -DGMP_INCLUDE_DIR="${CONDA_PREFIX}/include" \
        -DGMP_LIBRARIES="${CONDA_PREFIX}/lib/libgmp.so" \
        -DMPFR_INCLUDE_DIR="${CONDA_PREFIX}/include" \
        -DMPFR_LIBRARIES="${CONDA_PREFIX}/lib/libmpfr.so" \
        -DMSHR_ENABLE_VTK=0 \
        -DSWIG_EXECUTABLE="${INSTALLDIR}/swig/bin/swig"
    make -j 4
    make install
    rm -rf /tmp/mshr
}

#install_boost
#install_hdf5
#install_hypre
#install_scotch
#install_mumps
#install_petsc
#install_eigen
#install_swig
#install_fenics_python
#install_dolfin
#install_mshr
