#!/bin/bash

old="$(pwd)"
current="$(dirname "$0")"
cd $current

counter=1
while [ $counter -le 8 ]
do
    file=../testcell$counter
    ./gencell.sh $file.cell

    cp ../param.master $file.param

    mpirun -np 1 ../castep.mpi $file

    str=$(grep "Total energy corrected for finite basis" $file.castep)
    echo $file $(echo $str | awk '{print $9}') >> ../energies.dat

    mv $file.castep ../castep/

    counter=$(($counter+1))
done

cd $old
