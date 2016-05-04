#!/bin/bash

old="$(pwd)"
current="$(dirname "$0")"
root=..
cd $current

if [ ! -f $root/genatoms ] ; then
    exec make -C ..
fi

for i in {0..5}
do
    file=27_$i.cell
    head -n7 $root/cell.master > $file
    ../genatoms <<EOF >> $file
$i
EOF

    tail -n19 $root/cell.master | head -n10 >> $file
done
mv *.cell ../
cd $old

