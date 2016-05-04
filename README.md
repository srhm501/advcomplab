Group 6 Project
===============

DEPENDENCIES (tested with version)
----------------------------------

- gfortran (4.8.4, 5.3.0)
- GNU Make (3.81, 4.1)
- python 2.7, numpy, matplotlib
- BASH (4.3.11, 4.3.42)
- Java (Oracle, 1.8.0_91)

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