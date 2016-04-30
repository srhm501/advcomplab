#!/bin/bash
########################### CHANGE ME ###########################

incr=50			#increments to go up in
istart=250		#startvalue

test=Mg		#Put test as the prefix of cell-files you want to run
		#eg, for all cell files Mg0, Mg25 etc use test=Mg
################# Don't change!! ###################################

old="$(pwd)"
current="$(dirname "$0")"	# set up directory map
root=..
cd $current
cell=$root/cell			#set path to cell files
data=$root/dat			#set path to data files
castepdir=$root/castep		#set path to .castep output 

############### Running CASTEP FOR ALL CELL FILES $test*.cell#################
for system in $cell/$test*.cell
do
  conf=${celf::-5}			#remove.cell
  conf=${conf:8}			#remove path (../cell) for castep
  rm $data/$cutoff.dat
#if ! [ -s $data/$cutoff.dat ] ; then

######################## DON'T TOUTCH ########################
energy=100000
oldenergy=0
i=$istart
oldi=1
exitcond=1

while [ $exitcond -ne 0 ]
do
  exitcond=$(echo $energy $oldenergy | awk '{if (sqrt(($1-$2)^2) > 0.01) print 1; else print 0;}')
if [ $exitcond -eq 0 ]; then
  break				#Exit loop, energy has converged
fi 

file2=$cell/$cutoff.castep	#Castep path, Clear old castep to calculate
rm $file2			#For new cutoff energy
file=$cell/$cutoff.param

sed -i "/cut_off_energy/c\cut_off_energy     : "$i" eV." $file	
echo ''				#Update cutoff in param file
echo 'calculating energy using a cutoff energy of' $i 'eV'

time mpirun -np 1 $cell/castep.mpi $cell/$cutoff	#Run Castep

oldenergy=$energy
energy=$(exec ./findenergy.sh $file2)	#Find energy from castep file
echo $i $energy >> $data/$cutoff.dat	#Write cutoff eV and converged eV

oldi=$i				#Update previous values 
i=$((i+incr))			#Update cutoff eV
done
cd $old

filetoplot=$cutoff.dat	  	#pass in file name to plt
DOF=2				#degrees of freedom for fit use 2 !!!!!!!!!!
system=0	         	#0 for cut off energy plot, #1 for formation energy calc

python2 plotting.py << EOF
$filetoplot
$DOF
$system
EOF

display $filetoplot.png &	#Show total energy v cutoff
wait
done
