#!/bin/bash
#Script to create a dated copy of input file
day='date +%m-%d-%Y'
cp -rp $1 $1.$day
echo "The new file created is  $1.$day"
