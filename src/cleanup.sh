#!/bin/bash

old="$(pwd)"
current="$(dirname "$0")"
cd $current

rm ../cell/*.bib ../cell/*_bin ../cell/*.bands ../cell/*.err ../cell/*.check ../cell/*.cst_esp 2>/dev/null

cd $old
