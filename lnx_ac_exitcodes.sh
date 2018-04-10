#!/bin/bash
#Script to make use of exit codes

directory=$1

cd $directory 2> /dev/null

if [ $? -eq 0 ]; then
  ls *.sh
else
  echo "Enter a valid directory"
  exit 200
fi
