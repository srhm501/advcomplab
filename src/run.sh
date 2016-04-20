#!/bin/bash

# finds energy from file
# call as "./getenergy.sh config"

CASTEP_PATH=../castep

for cell in ../*.cell
do
    conf=${cell::-5}
    echo $conf
    cp ../param.master ../$conf.param
    mpirun -np 1 $CASTEP_PATH/castep.mpi $conf
    file=$CASTEP_PATH/$conf.castep
    ./jmol -I $file &
#STRING=$(grep "Total energy corrected for finite basis set" $FILE)
#ENERGY=$(echo $STRING | awk '{print $9}')
#echo $ENERGY
    ./cleanup.sh
done


