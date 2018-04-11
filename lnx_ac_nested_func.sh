#!/bin/bash
#Script to display the functionality of nested functions

#Global variables
GENDER=$1

#Global function-start
human() {
  ARMS=2
  LEGS=2
  echo "A human has $ARMS-ARMS and $LEGS-LEGS -What gender are we?"
  echo ""

  func_male() {
    BEARD=1
    echo "This man has $ARMS arms and $LEGS legs, with $BEARD beards"
    echo ""
  }

  func_female() {
    BEARD=0
    echo ""
    echo "The Woman has $ARMS and $LEGS and $BEARD beards"
    echo ""
  }
}

clear

echo "Determining the characteristics of the $GENDER"

echo ""

if [ $GENDER = "MALE" ]; then
  human
  func_male
else
  human
  func_female
fi

