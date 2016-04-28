#!/bin/bash
freedom=3
for file in ./e*.dat
do 
python plotting.py << EOF
$file
$freedom
EOF
done
display $file.png &
display eform.png &
