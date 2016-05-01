
#!/bin/bash

old="$(pwd)"
current="$(dirname "$0")"
root=..
cd $current
echo $old
if [ ! -f $root/genatoms ] ; then
    exec $root/make
fi

for i in {1..17}
do
    echo $i
    file=48_$i.cell
    head -n7 $root/cell.master > $file
    $root/genatoms <<EOF >> $file
$i
EOF

    tail -n19 $root/cell.master | head -n10 >> $file
done
mv *.cell ../
cd $old
