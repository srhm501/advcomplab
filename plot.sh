#!/bin/bash
freedom=2
for file in ./e*.dat
do 
python plotting.py << EOF
$file
$freedom
EOF
done
<<<<<<< HEAD
display $file.png &
=======
display $file.png &
display eform.png &
>>>>>>> test
