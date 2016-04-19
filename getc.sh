#!/bin/bash

# call as "./getcoords.sh file.cell"
for file in *.cell
do
name=${file::-5}
grep "^     O" $name > O_$name.dat
grep "^    Mg" $name > Mg_$name.dat
grep "^    Ca" $name > Ca_$name.dat
done

for FILE in *.dat; do
  gnuplot <<- EOF
    set xlabel "X"
    set ylabel "Y"
    set zlabel "Z"
    set grid
    set title "Position of Deuterium ion in a Toroidal and Poloidal Field"
    set term dumb
    splot "${FILE}" 
    set term png
    set output "${FILE}.png"
    splot "${FILE}" with vectors
EOF
display "${FILE}.png"
done
