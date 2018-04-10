#!/bin/bash
#Script to use IFS and delimiiters
echo "Enter the file to be read:"
read FILE
read -p "Enter the delimiter" IFS

while read -r CPU MEMORY DISK; do
  echo "CPU:$CPU"
  echo "MEMORY:$MEMORY"
  echo "DISK:$DISK"
done <"$FILE"
