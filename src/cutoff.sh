#!/bin/bash

rm ../cutoff.dat

for i in {250..400..10}
do
file2=../cutoff.castep
rm $file2
file=../cutoff.param
sed -i "/cut_off_energy/c\cut_off_energy     : "$i" eV." $file
echo 'calculating energy using a cutoff energy of' $i
mpirun -np 1 ../castep.mpi ../cutoff

STRING=$(grep "Total energy corrected for finite basis set" $file2)
ENERGY=$(echo $STRING | awk '{print $9}')
echo $i $ENERGY >> ../cutoff.dat

done