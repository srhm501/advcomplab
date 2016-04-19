#!/bin/bash

# call as "./getcoords.sh file.cell"

grep "^     O" $1 > O.dat
grep "^    Mg" $1 > Mg.dat
