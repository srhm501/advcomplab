Group 6 Project
===============

DEPENDENCIES (tested with version)
----------------------------------

- gfortran (4.8.4, 5.3.0)
    https://gcc.gnu.org/fortran/

- GNU Make (3.81, 4.1)
    https://www.gnu.org/software/make/

- python 2.7, numpy, matplotlib
    https://www.python.org/
    http://www.numpy.org/
    http://matplotlib.org/

- BASH (4.3.11, 4.3.42)
    https://www.gnu.org/software/bash/

- Java (Oracle, 1.8.0_91)
    https://www.oracle.com/uk/java/index.html

INSTALLATION AND RUNNING
------------------------

Assuming gfortran and GNU Make are in your $PATH,
inside the top level directory, run

`$ make`

or alternatively compile manually with the equivalent of

`$ gfortran src/intertype.f90 src/genatoms.f90 -o genatoms`

where the output executable must be called "genatoms" and be located
inside the top level directory.

To run the program, run

`$ src/master.sh`