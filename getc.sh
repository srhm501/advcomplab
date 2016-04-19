#!/bin/bash

# call as "./getcoords.sh file.cell"
for file in *.cell
do
name=${file::-5}
grep "^     O" $file | awk '{$1="O";sub("O","");print}' > O.dat
grep "^    Mg" $file | awk '{$1="Mg";sub("Mg","");print}' > Mg.dat
grep "^    Ca" $file | awk '{$1="Ca";sub("Ca","");print}' > Ca.dat
done

gnuplot <<- EOF
set xlabel "X"
set ylabel "Y"
set zlabel "Z"
set grid
set title ""
#set term dumb
#splot "${FILE}" 
set term png
set output "pos.png"
splot "Mg.dat", "O.dat"
EOF
display "pos.png"
done
