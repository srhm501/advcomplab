#!/bin/bash
freedom=2
for file in ./energy*.dat
do 
python plotting.py << EOF
$file
$freedom
EOF
done
display $file.png && display eform.png &