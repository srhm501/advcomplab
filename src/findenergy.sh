#!/bin/bash

# finds the final energy a from .castep file

file=$1

search=$(grep "Total energy corrected for finite basis set" $file)
energy=$(echo $search | awk '{print $9}')

echo $energy
