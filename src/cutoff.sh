#!/bin/bash

old="$(pwd)"
current="$(dirname "$0")"
root=..
cd $current
cell=$root/cell
data=$root/dat



for system in $cell/0.cell
do

#remove.cell
cutoff=${system::-5}
cutoff=${cutoff:8}
rm $data/$cutoff.dat
#if ! [ -s $data/$cutoff.dat ] ; then

########### CHANGE ME ##########
incr=20
i=200

######## DON'T TOUTCH #########
energy=100000
oldenergy=0
oldi=1
exitcond=1

while [ $exitcond -ne 0 ]
do
exitcond=$(echo $energy $oldenergy | awk '{if (sqrt(($1-$2)^2) > 0.001) print 1; else print 0;}')
if [ $exitcond -eq 0 ]; then
break
fi 

file2=$cell/$cutoff.castep
rm $file2
file=$cell/$cutoff.param

sed -i "/cut_off_energy/c\cut_off_energy     : "$i" eV." $file
echo 'calculating energy using a cutoff energy of' $i
time mpirun -np 1 $cell/castep.mpi $cell/$cutoff

oldenergy=$energy
energy=$(exec ./findenergy.sh $file2)
echo $i $energy >> $data/$cutoff.dat

oldi=$i
i=$((i+incr))
done
cd $old

#else 
echo "data file aready there!"
#fi

./plot.sh $data/$cutoff.dat 4
done
