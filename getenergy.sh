#!/bin/bash

# finds energy from file
# call as "./getenergy.sh file"

FILENAME=$1
STRING=$(grep "Total energy corrected for finite basis set" $FILENAME)
ENERGY=$(echo $STRING | awk '{print $9}')
echo $ENERGY
