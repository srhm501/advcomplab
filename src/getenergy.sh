#!/bin/bash

# finds energy from file
# call as "./getenergy.sh config"

CONF=$1
CASTEP_PATH=../castep

mpirun -np 1 $CASTEP_PATH/castep.mpi $CONF

FILE=$CASTEP_PATH/$CONF.castep

#STRING=$(grep "Total energy corrected for finite basis set" $FILE)
#ENERGY=$(echo $STRING | awk '{print $9}')
#echo $ENERGY

./jmol -I $FILE
