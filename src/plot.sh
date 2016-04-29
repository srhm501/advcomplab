#!/bin/bash
file=$1
freedom=$2

#pass in file to plt
#degrees of freedom for fit
#0 for 
python plotting.py << EOF
$file
$freedom
1
EOF

display $file.png &
display eform.png &

