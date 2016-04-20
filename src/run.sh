#!/bin/bash

# set up directory map
old="$(pwd)"
current="$(dirname "$0")"
root=..
castep_path=$root/castep
cd $current

# check if we can plot
[ -f ./Jmol.jar ] ; type -p java
plot=$?

for cell in $root/*.cell
do
    conf=${cell::-5}
    file=$castep_path/$conf.castep
    echo $conf
    cp ../param.master $conf.param

    if [ ! -f $file ] ; then
	mpirun -np 1 $castep_path/castep.mpi $conf
    fi

    if [[ plot -eq 0 ]] ; then
	./jmol -I $file
    fi

    ./cleanup.sh
done

#STRING=$(grep "Total energy corrected for finite basis set" $FILE)
#ENERGY=$(echo $STRING | awk '{print $9}')
#echo $ENERGY

cd $old
