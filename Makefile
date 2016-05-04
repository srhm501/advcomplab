FC=gfortran
FFLAGS=-c -O2 -std=f2008 -fcheck=all -Wall -Wextra

SRCS=src/intertype.f90 src/genatoms.f90
OBJS=$(SRCS:%.f90=%.o)

PROG=genatoms

$(PROG): $(OBJS)
	$(FC) $^ -o $@

%.o: %.f90
	$(FC) $(FFLAGS) $< -o $@

clean:
	rm $(PROG) *.mod src/*.o 2>/dev/null
