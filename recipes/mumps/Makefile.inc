#
#  This file is part of MUMPS 5.0.2, released
#  on Fri Jul 15 09:12:54 UTC 2016
#
# These settings for a PC under Debian/linux with standard packages :
# metis (parmetis), scotch (ptscotch), mpich, gfortran

# Begin orderings
LSCOTCH = -L$(PREFIX)/lib -lptesmumps -lptscotch -lscotch -lscotcherr
ISCOTCH = -I$(PREFIX)/include

LPORDDIR = $(topdir)/PORD/lib
IPORD    = -I$(topdir)/PORD/include
LPORD    = -L$(LPORDDIR) -lpord

# The following variables will be used in the compilation process.
# Please note that -Dptscotch and -Dparmetis imply -Dscotch and -Dmetis respectively.
# If you want to use Metis 4.X or an older version, you should use -Dmetis4 instead of -Dmetis
# or in addition with -Dparmetis (if you are using parmetis 3.X or older).
ORDERINGSF  = -Dptscotch -Dpord
ORDERINGSC  = $(ORDERINGSF)
LORDERINGS  = $(LSCOTCH) $(LPORD)
IORDERINGSF = $(ISCOTCH) $(IPORD)
IORDERINGSC = $(ISCOTCH) $(IPORD)
# End orderings

################################################################################

PLAT    =
LIBEXT  = .a
OUTC    = -o
OUTF    = -o
RM      = /bin/rm -f
CC      = mpicc
FC      = mpifort
FL      = mpifort
RANLIB := $(RANLIB)

# AR is defined in build.sh because defining it here is "difficult."
#AR      = ar vr

# SCALAP needs to have, at least the BLACS libs, in this order:
SCALAP = -lscalapack -lblacs -lblacs_F77init -lblacs

INCPAR = -I${PREFIX}/include
LIBPAR = $(SCALAP) -lmpi

LIBBLAS   = -lblas
LIBOTHERS = -lpthread

# Preprocessor defs for calling Fortran from C (-DAdd_ or -DAdd__ or -DUPPER)
CDEFS   = -DAdd_

# Begin Optimized options
OPTF = $(FFLAGS) -DALLOW_NON_INIT
OPTC = $(CFLAGS) -DALLOW_NON_INIT
OPTL = $(LDFLAGS) -DALLOW_NON_INIT
#End Optimized options

INCS = $(INCPAR)
LIBS = $(LIBPAR)
