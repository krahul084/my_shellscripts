#!/bin/bash
#Script to describe the operation of file descriptors

echo "Enter the filename to be read"
read -p "Filename: " FILE

exec 5<>$FILE

while read -r SUPERHERO; do
  echo "Your Superhero name is : $SUPERHERO"
done <&5

echo " #FILE was last read on `date`" >&5

exec 5>&-
