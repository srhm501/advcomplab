#!/bin/bash

old="$(pwd)"
current="$(dirname "$0")"
root=..
cd $current

if [ ! -f $root/genatoms ] ; then
    exec make -C $root
fi

if [ ! -f $root/cell ] ; then
    mkdir $root/cell
fi

for i in {0..10}
do
    file=$root/cell/27_$i.cell
    head -n7 $root/cell.master > $file
    ../genatoms <<EOF >> $file
$i
EOF

    tail -n19 $root/cell.master | head -n10 >> $file
done

cd $old
