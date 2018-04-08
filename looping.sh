#!/bin/bash

# find out who we are dealing with
clear
echo "Please enter your first name:"
read FIRSTNAME

#Make sure we get a single command line parameter
if [[ "$#" -lt 1 ]]; then
  echo "Usage: looping.sh[integer]"
  echo "Please Try Again!"
  exit 4
fi

#create a counting variable
COUNT=1

#Display a message while a count is less than or equal to the command line parameter
while [[ $COUNT -le $1 ]]; do
  echo "This is Loop Number $COUNT of $1"
  if [[ "$COUNT" -eq 3 ]]; then
    echo ""
    echo ""
    echo "CONGRATS YOU HAVE CROSSED THREE TIMES!"
    echo ""
    echo ""
  fi
  COUNT=$((COUNT + 1))
done
#Resetting the Count variable to the command line argument
COUNT=$1
#Count back to zero from the count value above
until [[ "$COUNT" -eq 0 ]]; do
  echo "Counting back to 0: $COUNT"
  COUNT=$((COUNT - 1))
done

#If the user is Bill, then display the message
if [[ "$FIRSTNAME" = "Bill" ]]; then
  echo "Thanks Bill! See You Later!"
else
  echo "Oh No! Why Didn't You Tell Me Your Name Was $FIRSTNAME"
  exit 1
fi
