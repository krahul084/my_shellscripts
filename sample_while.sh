#!/bin/bash
#Script to display the functionality of while/until loops
read -p "Please enter a how many times the loop should execute: " count
echo "This is for -while loop" 
var=1
while [ $var -le $count ]; do
  echo "this is loop: $var"
  (( ++var ))
done  
echo "###################"
echo "This is for-until loop"
var=1
until [ $var -gt $count ]; do
  echo "This is loop: $var"
  (( ++var))
done
