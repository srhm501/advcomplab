#!/bin/bash

for file in 27*.cell
do
seed=${file::-5}
#echo $seed
./run_castep seed
done
