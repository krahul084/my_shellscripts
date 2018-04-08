#!/bin/bash
#check to be sure we get a parameter
if [[ "$#" -lt 2  ]]; then
   echo "Usage: conditional.sh [string] [integer]"
   echo "Please try again!"
   exit 4
fi
#Check to see if we get confirmation
if [[  "$1" = "yes"  ]]; then
  echo "we have received confirmation"
else
  echo "we have not received confirmation.."
fi

#test to see if the integer passed second is greater than 10
if [[ "$2" -ge 10 ]]; then
  echo "the value is greater than 10, we got: $2"
else
  echo "The value is less than 10, we got: $2"
fi

