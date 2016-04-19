#!/bin/bash

# call as "./getcoords.sh file.cell"

grep "^     O" $1 | awk '{$1="O"; sub("O",""); print}' > O.dat
grep "^    Mg" $1 | awk '{$1="Mg"; sub("Mg",""); print}' > Mg.dat
