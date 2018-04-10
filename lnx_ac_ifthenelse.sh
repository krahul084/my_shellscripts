#!/bin/bash

#Script to explain if-then-else statements

echo "Please enter a number from 1-3"
read -p 'Number:' number

if [ $number == 1 ] 2> /dev/null || [ $number == 2 ] 2> /dev/null || [ $number == 3 ] 2> /dev/null ; then
  echo "Your have entered the correct number"
else
  echo "You have entered invalid number"
fi
