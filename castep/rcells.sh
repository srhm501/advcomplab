#!/bin/bash

<<<<<<< HEAD
for file in dan*.cell
=======
for file in ol*.cell
>>>>>>> be327888ba10f26679ddb4819ed781d58ba30750
do
seed=${file::-5}
#echo $seed
qsub run_castep $seed
#qsub run_castep 27_1
done
./cleanup.sh
