#!/bin/bash

# set up directory map
old="$(pwd)"
current="$(dirname "$0")"
root=..
cd $current
cell=$root/cell
data=$root/dat
castepdir=$root/castep
#name of ratio an energy dat file to be plotted
pltdata=energyplot.dat
rm ./$pltdata

# check if we can plot
[ -f ./Jmol.jar ] && [ $(type -p java) ]
plot=1

for celf in $cell/Mg*.cell
do
    #remove.cell
    conf=${celf::-5}
    #remove path (../cell) for castep
    conf=${conf:8}
    #set end .castep filename
    casf=$castepdir/$conf.castep
    echo $casf
    
    #print which cell file we are investigating
    echo $conf
    #generate param file, copy master in root dir
    cp ../param.master $conf.param
    
    #Find how many Mg and Ca lines in cell file
    numg=$(grep -c "Mg" $celf)
    numca=$(grep -c "Ca" $celf)
    
    #mg/total atoms
    ratio=$(echo $numg $numca | awk '{print $1/($1+$2)}')

    #If castep file exsists dont run again
    if [ ! -f $casf ] ; then
    echo
    #time mpirun -np 1 $cell/castep.mpi $cell/$conf
    fi

    #DONT PLOT IN JAVA UNLESS YOU NEED TO.
    #if [[ plot -eq 0 ]] ; then
#	./jmol -I $file
 #   fi
    
    #Find energy from .castep file
    energy=$(exec ./findenergy.sh $casf)
    #Write the percentage of Mg and total energy
    echo $ratio $energy  >> tmp.dat
done

sort -n tmp.dat > $pltdata
rm./tmp.dat

#pass in file name to plt
#degrees of freedom for fit use 2 !!!!!!!!!!
#0 for cut off energy plot, #1 for formation energy calc
python plotting.py << EOF
$pltdata
2
1
EOF


display $pltdata.png &
display eform.png &

cd $old
