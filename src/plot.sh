#!/bin/bash
freedom=$2
file=$1
#for file in ./dat/*.dat
#do 
python plotting.py << EOF
$file
$freedom
EOF
#done

display $file.png &
#display eform.png &

