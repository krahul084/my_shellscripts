#!/bin/bash
#Nested if statements

if [ $1 -gt 100 ]
then
  echo hey its a large number.

  if (( $1 % 2 == 0 ))
  then
    echo And its also an even number
  fi
fi
