#!/bin/bash
#Script to read files and processing
echo "Enter the file to be read"
read FILE

while read -r SUPERHERO; do
  echo "Superhero name is : $SUPERHERO"
done < "$FILE"
