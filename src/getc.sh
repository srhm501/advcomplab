#!/bin/bash

# NOTE: this will write coords in all .cell files to the 3 .dat files
#       we should write to specific .dat files using $name, but will
#       need to fix the gnuplot call

for file in ../*.cell
do
    name=${file::-5}
    name=${name:3}
    echo $name
    grep "O "  $file | awk '{$1="O";sub("O","");print}'   > ../dat/$name.dat
    grep "Mg " $file | awk '{$1="Mg";sub("Mg","");print}' > ../dat/$name.dat
    grep "Ca " $file | awk '{$1="Ca";sub("Ca","");print}' > ../dat/$name.dat

    gnuplot << EOF
        set xlabel "X"
        set ylabel "Y"
        set zlabel "Z"
        set grid
        set title "Atom positions"
        set term png
        set output "../dat/pos_$name.png"
        splot "../dat/$name.dat" pt 7 ps 5, \
              "../dat/$name.dat"  pt 7 ps 5, \
              "../dat/$name.dat" pt 7 ps 5
        set term wxt
        replot
EOF
    display "../dat/pos_$name.png" &
done
