#!/bin/bash

file=$1
search=$(grep "Total energy corrected for finite basis set" $file)
energy=$(echo $search | awk '{print $9}')

echo $energy
