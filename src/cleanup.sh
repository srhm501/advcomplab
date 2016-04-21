#!/bin/bash

old="$(pwd)"
current="$(dirname "$0")"
cd $current

rm ../*.bib ../*_bin ../*.bands ../*.err ../*.check ../*.cst_esp 2>/dev/null

cd $old
