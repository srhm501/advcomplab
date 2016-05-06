#!/bin/bash

old="$(pwd)"
current="$(dirname "$0")"
root=..
cd $current

if [ ! -f $root/genatoms ] ; then
    exec make -C $root
fi

if [ ! -d $root/cell ] ; then
    mkdir $root/cell
fi

# use cell.master to get the lattice dimensions
# from the top and bottom of the file
for i in {0..10}
do
    file=$root/cell/27_$i.cell

    head -n7 $root/cell.master > $file

    # get atoms positions
    ../genatoms <<EOF >> $file
$i
EOF

    tail -n19 $root/cell.master | head -n10 >> $file
done

cd $old
