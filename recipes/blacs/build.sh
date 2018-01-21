#!/usr/bin/env bash
set -e

source "${RECIPE_DIR}/fix-environment.sh"

cp "${RECIPE_DIR}/SRC_MPI_Makefile" SRC/MPI/Makefile
cp "${RECIPE_DIR}/TESTING_Makefile" TESTING/Makefile
cp "${RECIPE_DIR}/TESTING_blacstest.f" TESTING/blacstest.f

make -j "${CPU_COUNT}" mpi

make tester

ln -s "${SRC_DIR}/TESTING/bt.dat" .
ln -s "${SRC_DIR}/TESTING/bsbr.dat" .
ln -s "${SRC_DIR}/TESTING/comb.dat" .
ln -s "${SRC_DIR}/TESTING/sdrv.dat" .

export LD_LIBRARY_PATH="${PREFIX}/lib"
mpirun -np "${CPU_COUNT}" "${PREFIX}/xCbtest"
mpirun -np "${CPU_COUNT}" "${PREFIX}/xFbtest"

rm "${PREFIX}/xCbtest"
rm "${PREFIX}/xFbtest"

unlink bt.dat
unlink bsbr.dat
unlink comb.dat
unlink sdrv.dat
