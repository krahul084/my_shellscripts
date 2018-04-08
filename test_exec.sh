#!/bin/bash
#Script to check if the file has needed permissions

if [ -x $1 ] && [ -w $1 ]
then
  echo The file is ready for commit
else
  echo the file is not ready for commit
fi
