#!/bin/bash

head -n6 ../cell.master > $1

tail -n17 ../cell.master | head -n8 >> $1
