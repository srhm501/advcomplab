#!/bin/bash

# NOTE: this will write coords in all .cell files to the 3 .dat files
#       we should write to specific .dat files using $name, but will
#       need to fix the gnuplot call

for file in ../test*.cell
do
    name=${file::-5}
    name=${name:3}
    echo $name

    numg=$(grep -c "Mg" $file)
    numca=$(grep -c "Ca" $file)

    ratio=$(echo $numg $numca | awk '{print $1/$2}')
    STRING=$(grep "Total energy corrected for finite basis set" $file)
    energy=$(echo $STRING | awk '{print $9}')
    cat << EOF
$ratio $energy
EOF
    gnuplot << EOF
        set xlabel "X"
        set ylabel "Y"
        set zlabel "Z"
        set grid
        set title "Atom positions"
        set term png
        set output "../dat/pos_$name.png"
        #splot "../dat/O_$name.dat" pt 7 ps 5, \
              "../dat/Mg_$name.dat"  pt 7 ps 5, \
              "../dat/Ca_$name.dat" pt 7 ps 5
        set term wxt
        replot
EOF
    display "../dat/pos_$name.png" &
done
