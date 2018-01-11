#!/usr/bin/env bash

cd src
cp "${RECIPE_DIR}/Makefile.inc.x86-64_pc_linux2" Makefile.inc
export CPATH="${PREFIX}/include:${CPATH}"
make -j "${CPU_COUNT}" ptscotch
make prefix="${PREFIX}" install

rm "${PREFIX}/share/man/man1/amk_ccc.1"
rm "${PREFIX}/share/man/man1/amk_fft2.1"
rm "${PREFIX}/share/man/man1/amk_hy.1"
rm "${PREFIX}/share/man/man1/amk_m2.1"
rm "${PREFIX}/share/man/man1/amk_p2.1"
rm "${PREFIX}/share/man/man1/atst.1"
rm "${PREFIX}/share/man/man1/dgmap.1"
rm "${PREFIX}/share/man/man1/dgord.1"
rm "${PREFIX}/share/man/man1/dgpart.1"
rm "${PREFIX}/share/man/man1/dgscat.1"
rm "${PREFIX}/share/man/man1/dgtst.1"
rm "${PREFIX}/share/man/man1/gcv.1"
rm "${PREFIX}/share/man/man1/gmap.1"
rm "${PREFIX}/share/man/man1/gmk_hy.1"
rm "${PREFIX}/share/man/man1/gmk_m2.1"
rm "${PREFIX}/share/man/man1/gmk_m3.1"
rm "${PREFIX}/share/man/man1/gmk_msh.1"
rm "${PREFIX}/share/man/man1/gmk_ub2.1"
rm "${PREFIX}/share/man/man1/gmtst.1"
rm "${PREFIX}/share/man/man1/gord.1"
rm "${PREFIX}/share/man/man1/gotst.1"
rm "${PREFIX}/share/man/man1/gout.1"
rm "${PREFIX}/share/man/man1/gpart.1"
rm "${PREFIX}/share/man/man1/gtst.1"
rm "${PREFIX}/share/man/man1/mmk_m2.1"
rm "${PREFIX}/share/man/man1/mmk_m3.1"
rm "${PREFIX}/share/man/man1/mord.1"
rm "${PREFIX}/share/man/man1/mtst.1"

