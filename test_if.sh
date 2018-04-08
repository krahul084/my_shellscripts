#!/bin/bash
#test if which number is greater

if [ $1 -gt $2 ]
then
  echo $1 is greater
elif [ $2 -gt $1 ]
then
  echo $2 is greater
elif [ $1 -eq $2 ]
then
  echo Both are equal
else
  echo Please pass appropriate inputs
fi
