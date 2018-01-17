EXE        =
LIB        = .a
OBJ        = .o

MAKE       = make
AR        := $(AR)
ARFLAGS    = -ruv
CAT        = cat
CCS       := $(GCC)
CCP        = mpicc
CCD        = mpicc
CFLAGS     = -O3 -DCOMMON_FILE_COMPRESS_GZ -DCOMMON_PTHREAD -DCOMMON_RANDOM_FIXED_SEED -DSCOTCH_RENAME -DSCOTCH_PTHREAD -Drestrict=__restrict -DIDXSIZE64 -DSCOTCH_PTHREAD_NUMBER=2
CLIBFLAGS  =
LDFLAGS    = -L$(CONDA_PREFIX)/lib -lz -lm -lrt -pthread
CP         = cp
LEX        = flex -Pscotchyy -olex.yy.c
LN         = ln
MKDIR      = mkdir
MV         = mv
RANLIB    := $(RANLIB)
YACC       = bison -pscotchyy -y -b y
