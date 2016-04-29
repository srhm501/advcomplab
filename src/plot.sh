#!/bin/bash
freedom=$2
file=$1
#for file in ./dat/*.dat
#do 

#pass in file to plt
#degrees of freedom for fit
#0 for 
python plotting.py << EOF
$file
$freedom
1
EOF
#done

display $file.png &
display eform.png &

