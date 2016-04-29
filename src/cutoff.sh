#!/bin/bash

old="$(pwd)"
current="$(dirname "$0")"
root=..
cd $current
cell=$root/cell
data=$root/dat
rm $data/cutoff.dat

for system in $cell/*.cell
do

if ! [ -s $data/cutoff.dat ] ; then
for i in {250..400..10}
do
file2=$cell/cutoff.castep
rm $file2
file=$cell/cutoff.param
sed -i "/cut_off_energy/c\cut_off_energy     : "$i" eV." $file
echo 'calculating energy using a cutoff energy of' $i
mpirun -np 1 $cell/castep.mpi $cell/cutoff

energy=$(exec ./findenergy.sh $file2)
echo $i $energy >> $data/cutoff.dat

oldenergy=$enery
done
cd $old

else 
echo "data file aready there!"
fi

./plot.sh $data/cutoff.dat 4
done
