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
    if [ $numca -eq 0 ]; then
    echo
    else #mg/ca
    ratio=$(echo $numg $numca | awk '{print $1/$2}')
    fi
    
    energy=$(exec ./findenergy.sh ./castep/$name.castep)

echo $ratio $energy  >> energyplot.dat

done

# gnuplot << EOF
#     set xlabel "Ratio of Mg/Ca"
#     set ylabel "Energy (eV)"
#     set grid
#     unset key
#     set title "Energy variation with Mg/Ca ratio"
#     set term png
#     set output "./dat/pos_$name.png"
#     plot "energyplot.dat" using 1:2 with lines
#     set term wxt
#     replot
# EOF
# 
# display "./dat/pos_$name.png" &
python plotting.py << EOF 
energyplot.dat
2
1
EOF