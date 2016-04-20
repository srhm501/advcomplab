#!/bin/bash

CASTEP_PATH=../castep

# check if we can plot
[ -f ./Jmol.jar ] ; type -p java
plot=$?

for cell in ../*.cell
do
    conf=${cell::-5}
    file=$CASTEP_PATH/$conf.castep
    echo $conf
    cp ../param.master $conf.param

    if [ ! -f $file ] ; then
	mpirun -np 1 $CASTEP_PATH/castep.mpi $conf
    fi

    if [[ plot -eq 0 ]] ; then
	./jmol -I $file
    fi

#STRING=$(grep "Total energy corrected for finite basis set" $FILE)
#ENERGY=$(echo $STRING | awk '{print $9}')
#echo $ENERGY
    ./cleanup.sh
done


