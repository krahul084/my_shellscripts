#!/bin/bash
#script to explain for loops
shell_scripts=$(ls *.sh)
for script in $shell_scripts; do
  echo "############################################"
  echo $script
  echo "#############################################"
  cat $script
done
