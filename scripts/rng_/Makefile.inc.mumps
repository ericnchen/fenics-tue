#
#  This file is part of MUMPS 5.1.1, released
#  on Tue Mar 21 14:55:59 UTC 2017
#
#Begin orderings

SCOTCHDIR  = ${HOME}/.local/opt/fenics-mkl-2017.1.0/scotch
LSCOTCH    = -L$(SCOTCHDIR)/lib -lptesmumps -lptscotch -lscotcherr -lscotch -L${HOME}/.local/opt/miniconda3/envs/intel/lib -lz
ISCOTCH    = -I$(SCOTCHDIR)/include

LPORDDIR = $(topdir)/PORD/lib/
IPORD    = -I$(topdir)/PORD/include/
LPORD    = -L$(LPORDDIR) -lpord

# The following variables will be used in the compilation process.
# Please note that -Dptscotch and -Dparmetis imply -Dscotch and -Dmetis respectively.
# If you want to use Metis 4.X or an older version, you should use -Dmetis4 instead of -Dmetis
# or in addition with -Dparmetis (if you are using parmetis 3.X or older).
ORDERINGSF  = -Dptscotch -Dpord
ORDERINGSC  = -Dptscotch -Dpord

LORDERINGS  = $(LSCOTCH) $(LPORD) 
IORDERINGSF = $(ISCOTCH) $(IPORD)
IORDERINGSC = $(ISCOTCH) $(IPORD) 

#End orderings
########################################################################
################################################################################

PLAT    =
LIBEXT  = .a
OUTC    = -o 
OUTF    = -o 
RM = /bin/rm -f
CC = mpicc
FC = mpifort
FL = mpifort
AR = ar vr 
RANLIB = ranlib

MKLROOT=/home/echen/.local/opt/miniconda3/envs/intel/lib
LAPACK = -L$(MKLROOT) -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl
SCALAP = -L$(MKLROOT) -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl -lmkl_blacs_openmpi_lp64 -lmkl_scalapack_lp64

LIBPAR = $(SCALAP) $(LAPACK)

INCSEQ = -I$(topdir)/libseq
LIBSEQ  = $(LAPACK) -L$(topdir)/libseq -lmpiseq

LIBBLAS = -L$(MKLROOT) -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl
LIBOTHERS = -lpthread

#Preprocessor defs for calling Fortran from C (-DAdd_ or -DAdd__ or -DUPPER)
CDEFS   = -DAdd_

#Begin Optimized options
OPTF    = -O3 -fPIC -DALLOW_NON_INIT
OPTL    = -O3 -fPIC
OPTC    = -O3 -fPIC
#End Optimized options
INCS = $(INCPAR)
LIBS = $(LIBPAR)
LIBSEQNEEDED =
