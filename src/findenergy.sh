#!/bin/bash

file=$1
celf=$2
#Find how many Mg and Ca lines in cell file
# numg=$(grep -c "Mg" $celf)
# numca=$(grep -c "Ca" $celf)
#     
# #mg/total atoms
# ratio=$(echo $numg $numca | awk '{print $1/($1+$2)}')

search=$(grep "Total energy corrected for finite basis set" $file)
energy=$(echo $search | awk '{print $9}')

echo $energy
# 
# python plotting.py << EOF
# energy.dat
# 2
# 1
# EOF