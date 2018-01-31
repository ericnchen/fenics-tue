#!/usr/bin/env bash
set -e

cp "${RECIPE_DIR}/SLmake.inc" SLmake.inc
cp "${RECIPE_DIR}/TOOLS_Makefile" TOOLS/Makefile

make toolslib
make pblaslib
make redistlib
make scalapacklib

mv libscalapack.a "${PREFIX}/lib/libscalapack.a"
ln -s "${PREFIX}/lib/libscalapack.a" libscalapack.a

# These are additional select routines that the testcases need.
compile_testing_tools() {
  mkdir TESTING_TOOLS

  cp TOOLS/LAPACK/icopy.f                   TESTING_TOOLS/icopy.f
  cp "${RECIPE_DIR}/TESTING_TOOLS.Makefile" TESTING_TOOLS/Makefile

  (cd TESTING_TOOLS && make all)

  mv TESTING_TOOLS/libtestingtools.a libtestingtools.a
}

# Make and test all PBLAS testcases.
test_pblas() {
  make pblasexe

  (cd PBLAS/TESTING && mpirun -np "${CPU_COUNT}" xspblas1tst)
  (cd PBLAS/TESTING && mpirun -np "${CPU_COUNT}" xdpblas1tst)
  (cd PBLAS/TESTING && mpirun -np "${CPU_COUNT}" xcpblas1tst)
  (cd PBLAS/TESTING && mpirun -np "${CPU_COUNT}" xzpblas1tst)
  (cd PBLAS/TESTING && mpirun -np "${CPU_COUNT}" xspblas2tst)
  (cd PBLAS/TESTING && mpirun -np "${CPU_COUNT}" xdpblas2tst)
  (cd PBLAS/TESTING && mpirun -np "${CPU_COUNT}" xcpblas2tst)
  (cd PBLAS/TESTING && mpirun -np "${CPU_COUNT}" xzpblas2tst)
  (cd PBLAS/TESTING && mpirun -np "${CPU_COUNT}" xspblas3tst)
  (cd PBLAS/TESTING && mpirun -np "${CPU_COUNT}" xdpblas3tst)
  (cd PBLAS/TESTING && mpirun -np "${CPU_COUNT}" xcpblas3tst)
  (cd PBLAS/TESTING && mpirun -np "${CPU_COUNT}" xzpblas3tst)
  (cd PBLAS/TIMING && mpirun -np "${CPU_COUNT}" xspblas1tim)
  (cd PBLAS/TIMING && mpirun -np "${CPU_COUNT}" xdpblas1tim)
  (cd PBLAS/TIMING && mpirun -np "${CPU_COUNT}" xcpblas1tim)
  (cd PBLAS/TIMING && mpirun -np "${CPU_COUNT}" xzpblas1tim)
  (cd PBLAS/TIMING && mpirun -np "${CPU_COUNT}" xspblas2tim)
  (cd PBLAS/TIMING && mpirun -np "${CPU_COUNT}" xdpblas2tim)
  (cd PBLAS/TIMING && mpirun -np "${CPU_COUNT}" xcpblas2tim)
  (cd PBLAS/TIMING && mpirun -np "${CPU_COUNT}" xzpblas2tim)
  (cd PBLAS/TIMING && mpirun -np "${CPU_COUNT}" xspblas3tim)
  (cd PBLAS/TIMING && mpirun -np "${CPU_COUNT}" xdpblas3tim)
  (cd PBLAS/TIMING && mpirun -np "${CPU_COUNT}" xcpblas3tim)
  (cd PBLAS/TIMING && mpirun -np "${CPU_COUNT}" xzpblas3tim)
}

# Make and test all REDIST testcases.
test_redist() {
  cp "${RECIPE_DIR}/SLmake.inc" SLmake.inc

  echo "BLACSLIB      = -lblacs_F77init -lblacs -lblacs_F77init" >> SLmake.inc
  echo "LIBS          = \$(BLACSLIB) \$(LAPACKLIB) \$(BLASLIB) -lmpi_mpifh" >> SLmake.inc

  make redistexe

  (cd REDIST/TESTING && mpirun -np "${CPU_COUNT}" xigemr)
  (cd REDIST/TESTING && mpirun -np "${CPU_COUNT}" xsgemr)
  (cd REDIST/TESTING && mpirun -np "${CPU_COUNT}" xdgemr)
  (cd REDIST/TESTING && mpirun -np "${CPU_COUNT}" xcgemr)
  (cd REDIST/TESTING && mpirun -np "${CPU_COUNT}" xzgemr)
  (cd REDIST/TESTING && mpirun -np "${CPU_COUNT}" xitrmr)
  (cd REDIST/TESTING && mpirun -np "${CPU_COUNT}" xstrmr)
  (cd REDIST/TESTING && mpirun -np "${CPU_COUNT}" xdtrmr)
  (cd REDIST/TESTING && mpirun -np "${CPU_COUNT}" xctrmr)
  (cd REDIST/TESTING && mpirun -np "${CPU_COUNT}" xztrmr)
}


# Make and test all ScaLAPACK testcases.
test_scalapack() {
  cp "${RECIPE_DIR}/SLmake.inc" SLmake.inc

  compile_testing_tools
  echo "LIBS          := ../../libtestingtools.a \$(LIBS)" >> SLmake.inc

  make scalapackexe

  (cd TESTING && mpirun -np "${CPU_COUNT}" xslu)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xdlu)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xclu)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xzlu)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xsdblu)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xddblu)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xcdblu)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xzdblu)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xsdtlu)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xddtlu)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xcdtlu)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xzdtlu)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xsgblu)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xdgblu)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xcgblu)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xzgblu)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xsllt)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xdllt)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xcllt)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xzllt)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xspbllt)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xdpbllt)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xcpbllt)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xzpbllt)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xsptllt)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xdptllt)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xcptllt)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xzptllt)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xsinv)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xdinv)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xcinv)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xzinv)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xsqr)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xdqr)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xcqr)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xzqr)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xsls)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xdls)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xcls)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xzls)

  (cd TESTING && mpirun -np "${CPU_COUNT}" xshrd)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xdhrd)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xchrd)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xzhrd)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xstrd)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xdtrd)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xctrd)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xztrd)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xsbrd)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xdbrd)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xcbrd)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xzbrd)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xssep)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xdsep)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xcsep)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xzsep)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xsgsep)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xdgsep)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xcgsep)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xzgsep)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xssvd)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xdsvd)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xsnep)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xdnep)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xcnep)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xznep)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xcevc)
  (cd TESTING && mpirun -np "${CPU_COUNT}" xzevc)
}

export LD_LIBRARY_PATH="${PREFIX}/lib"
test_pblas
test_redist
test_scalapack
