#!/bin/bash

#Display all the scripts in the current directory and cat them to the console

for FILE in $( ls *.sh); do
  echo "==========================="
  echo "NAME: $FILE"
  echo "==========================="
  cat $FILE
  echo "==========================="
done
