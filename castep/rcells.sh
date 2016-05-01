#!/bin/bash

for file in 27*.cell
do
seed=${file::-5}
#echo $seed
qsub run_castep $seed
#qsub run_castep 27_1
done
