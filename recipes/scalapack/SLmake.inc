############################################################################
#
#  Program:         ScaLAPACK
#
#  Module:          SLmake.inc
#
#  Purpose:         Top-level Definitions
#
#  Creation date:   February 15, 2000
#
#  Modified:        October 13, 2011
#
#  Send bug reports, comments or suggestions to scalapack@cs.utk.edu
#
############################################################################
#
#  C preprocessor definitions:  set CDEFS to one of the following:
#
#     -DNoChange (fortran subprogram names are lower case without any suffix)
#     -DUpCase   (fortran subprogram names are upper case without any suffix)
#     -DAdd_     (fortran subprogram names are lower case with "_" appended)

CDEFS         = -DAdd_

#
#  The fortran and C compilers, loaders, and their flags
#

FC            = mpif77
CC            = mpicc
NOOPT         = -O0 -fPIC -ftree-vectorize -fno-plt -pipe
FCFLAGS       = $(FFLAGS)
CCFLAGS       = $(CFLAGS)
FCLOADER      = $(FC)
CCLOADER      = $(CC)
FCLOADFLAGS   = $(LDFLAGS)
CCLOADFLAGS   = $(LDFLAGS)

#
#  The archiver and the flag(s) to use when building archive (library)
#  Also the ranlib routine.  If your system has no ranlib, set RANLIB = echo
#

ARCH          := $(AR)
ARCHFLAGS     = cr
RANLIB        := $(RANLIB)

#
#  The name of the ScaLAPACK library to be created
#

SCALAPACKLIB  = libscalapack.a

#
#  BLAS, LAPACK (and possibly other) libraries needed for linking test programs
#

BLASLIB       = -lblas
LAPACKLIB     = -llapack
BLACSLIB      = -lblacs_F77init -lblacs -lblacs_F77init
LIBS          = $(BLACSLIB) $(LAPACKLIB) $(BLASLIB)
