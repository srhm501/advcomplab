#!/bin/bash

# NOTE: this will write coords in all .cell files to the 3 .dat files
#       we should write to specific .dat files using $name, but will
#       need to fix the gnuplot call
rm ./energyplot.dat
for file in ./*.cell
do
    name=${file::-5}
    name=${name:2}

    numg=$(grep -c "Mg" $file)
    numca=$(grep -c "Ca" $file)
    ratio=$(echo $numg $numca | awk '{print $1/$2}')

    STRING=$(grep "Total energy corrected for finite basis set" ./castep/$name.castep)
    energy=$(echo $STRING | awk '{print $9}')

echo $ratio $energy  >> energyplot.dat
done

gnuplot << EOF
    set xlabel "X"
    set ylabel "Y"
    set zlabel "Z"
    set grid
    set title "Atom positions"
    set term png
    set output "./dat/pos_$name.png"
    plot "energyplot.dat" using 1:2 with lines
    set term wxt
    replot
EOF

display "./dat/pos_$name.png" &
