#!/bin/bash
#Sample bash script for- for loop
for i in {1..100..3}; do
 echo "Hello this is a for loop $i"
done

for value in $1/*.sh
do
  cp $value $1/$( basename -s .sh $value ).php
done
