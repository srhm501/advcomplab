#!/bin/bash

old="$(pwd)"
current="$(dirname "$0")"
root=..
cd $current

if [ ! -f $root/genatoms ] ; then
    echo "genatoms doesn't exist: run \"make\" in the top directory"
    exit 1
fi

head -n11 $root/cell.master > $1

$root/genatoms >> $1

tail -n19 $root/cell.master | head -n10 >> $1

cd $old
