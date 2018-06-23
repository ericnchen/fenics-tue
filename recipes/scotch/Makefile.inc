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
CFLAGS    := $(CFLAGS) -DCOMMON_FILE_COMPRESS_GZ -DCOMMON_PTHREAD -DCOMMON_RANDOM_FIXED_SEED -DSCOTCH_RENAME -Drestrict=__restrict -DIDXSIZE64
CLIBFLAGS  =
LDFLAGS   := $(LDFLAGS) -lz -lm -lrt -pthread
CP         = cp
LEX        = flex -Pscotchyy -olex.yy.c
LN         = ln
MKDIR      = mkdir
MV         = mv
RANLIB    := $(RANLIB)
YACC       = bison -pscotchyy -y -b y

# TODO: Try these options in the future to build a shared library.
# LIB		= .so
# AR		= gcc
# ARFLAGS		= -shared -o
# CLIBFLAGS	= -shared -fPIC
