include ../SLmake.inc

ALLTOOLS = icopy.o

all: alltestingtools

alltestingtools: $(ALLTOOLS)
	$(ARCH) $(ARCHFLAGS) libtestingtools.a $(ALLTOOLS)
	$(RANLIB) libtestingtools.a

.f.o : ; $(FC) -c $(FCFLAGS) $*.f
