#!/bin/bash

# finds energy from file
# call as "./getenergy.sh config"

CONF=$1
mpirun -np 1 castep.mpi $CONF

FILE=$CONF.castep

STRING=$(grep "Total energy corrected for finite basis set" $FILE)
ENERGY=$(echo $STRING | awk '{print $9}')
echo $ENERGY
