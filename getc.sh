#!/bin/bash

# call as "./getcoords.sh file.cell"
for file in *.cell
do
name=${file::-5}
grep "^     O" $name | awk '{$1="O";sub("O","");print}' > O_$name.dat
grep "^    Mg" $name | awk '{$1="Mg";sub("Mg","");print}' > Mg_$name.dat
grep "^    Ca" $name | awk '{$1="Ca";sub("Ca","");print}' > Ca_$name.dat
done

for FILE in *.dat; do
  gnuplot <<- EOF
    set xlabel "X"
    set ylabel "Y"
    set zlabel "Z"
    set grid
    set title ""
    set term dumb
    splot "${FILE}" 
    set term png
    set output "${FILE}.png"
    splot "${FILE}"
EOF
display "${FILE}.png"
done
