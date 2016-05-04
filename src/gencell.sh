#!/bin/bash

old="$(pwd)"
current="$(dirname "$0")"
root=..
cd $current
echo $old
if [ ! -f $root/genatoms ] ; then
    exec $root/make
fi

for i in {0..10}
do
    file=27_$i.cell
    echo $i
    head -n7 $root/cell.master > $file
    $root/genatoms <<EOF >> $file
$i
EOF

    tail -n19 $root/cell.master | head -n10 >> $file
done

mv *.cell ../

cd $old

