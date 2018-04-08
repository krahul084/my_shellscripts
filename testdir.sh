#!/bin/bash


#Test if a value is a Directory

if [[  -d "$1"  ]]; then
  echo "The value $1 is a directory"
else 
  echo "The value $1 is not a directory"
fi
