#!/bin/bash
########## Put test as the prefix of cell-   #################################
########## files you want to run castep for  #################################

test=Mg			#eg, for all cell files Mg0, Mg25 etc use test=Mg
pltdata=energyplot.dat	#name of ratio an energy dat file to be plotted

################# Don't change!! ###################################

old="$(pwd)"
current="$(dirname "$0")"	# set up directory map
cd $current
root=..
cell=$root/cell			#set path to cell files
data=$root/dat			#set path to data files
castepdir=$root/castep		#set path to .castep output 

rm ./$pltdata

[ -f ./Jmol.jar ] && [ $(type -p java) ]	#check if we can plot
plot=1						#plot=1 means DONT plot ever
                                                # set to $? to plot when able

if [ ! -d $cell ] ; then
    mkdir $cell
fi
if [ ! -d $data ] ; then
    mkdir $data
fi
fi [ ! -d $castepdir ] ; then
    mkdir $castepdir
fi

############### Running CASTEP FOR ALL CELL FILES $*.cell#################

for celf in $cell/$*.cell
do
  conf=${celf::-5}			#remove.cell
  conf=${conf:8}			#remove path (../cell) for castep
  casf=$castepdir/$conf.castep		#set end .castep filename
    
  echo $conf				#print which cell file we are investigating
  cp ../param.master $cell/$conf.param 	#generate param file, copy master in root dir
    
  numg=$(grep -c "Mg" $celf)		#Find how many Mg and Ca lines in cell file
  numca=$(grep -c "Ca" $celf)		#Then write Mg/total atoms
  ratio=$(echo $numg $numca | awk '{print $1/($1+$2)}')
    
  if [ ! -f $casf ] ; then		#If castep file exists dont run again
    echo "Running castep for system" $conf
    time mpirun -np 1 $cell/castep.mpi $cell/$conf
    mv $cell/$conf.castep $castepdir
  else					#Can skip running castep
      echo "Didn't run castep, file already exists"		
  fi

  if [[ plot -eq 0 ]] ; then		#DONT PLOT IN JAVA UNLESS YOU NEED TO.
      ./jmol.sh -I $file	       	#plot is set to false at top of script
  fi
    
  energy=$(exec ./findenergy.sh $casf)  #Find energy from .castep file
  echo $ratio $energy  >> tmp.dat  	#Write the percentage of Mg and total energy
done					#write to temporary file

################ END OF MAIN LOOP FOR RUNNING CASTEP ##################################

sort -n tmp.dat > $pltdata	#sort the percentage composition and energies
				#from the temp file into accending order for data analysis
rm ./tmp.dat			#Remove Temp file

filetoplot=$pltdata	  	#pass in file name to plt
DOF=2		      	 	#degrees of freedom for fit use 2 !!!!!!!!!!
system=1	         	#0 for cut off energy plot, #1 for formation energy calc

python2 plotting.py << EOF
$filetoplot
$DOF
$system
EOF

display $filetoplot.png &	#Show percentage to total energy
display eform.png &		#Show Formation energy plot
wait
cd $old
