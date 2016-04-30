
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
head -n7 $root/cell.master > $i.cell
$root/genatoms <<EOF >> $i.cell
$i
EOF

tail -n19 $root/cell.master | head -n10 >> $i.cell
done
mv *.cell ../
cd $old
