#!/bin/bash

# set up directory map
old="$(pwd)"
current="$(dirname "$0")"
root=..
cd $current
cell=$root/cell
data=$root/dat

# check if we can plot
[ -f ./Jmol.jar ] && [ $(type -p java) ]
plot=1

for celf in $cell/Mg*.cell
do
    echo $celf
    conf=${cell::-5}
    conf=${conf:8}
    casf=$cell/$conf.castep
    echo $conf
    cp ../param.master $conf.param
    
    numg=$(grep -c "Mg" $celf)
    numca=$(grep -c "Ca" $celf)
    #if [ $numca -eq 0 ]; then
    echo
    #else #mg/total atoms
    ratio=$(echo $numg $numca | awk '{print $1/($1+$2)}')
    #fi

    #if [ ! -f $file ] ; then
    time mpirun -np 1 $cell/castep.mpi $cell/$conf
    #fi

    if [[ plot -eq 0 ]] ; then
	./jmol -I $file
    fi

    #../cleanup.sh
    energy=$(exec ./findenergy.sh $casf)
    echo $ratio $energy  >> energyplot.dat
done

#!/bin/bash
#freedom=$2
#file=$1
#for file in ./dat/*.dat
#do 

#pass in file to plt
#degrees of freedom for fit
#0 for 
python plotting.py << EOF
$data/energyplot.dat
2
1
EOF
#done

display $file.png &
display eform.png &

cd $old
