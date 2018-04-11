#!/bin/bash
#script to display the functionality of the input box
#Global variables
INPUTBOX=${INPUTBOX=dialog}
TITLE="INPUT"
MESSAGE="Please enter an input to capture"
XCOORD=10
YCOORD=22

#Function Declaration for INPUTBOX-start
display_inputbox() {
  $INPUTBOX --title "$1" --inputbox "$2" $3 $4 2>tmpfile.txt
  echo "Operation complete"
}
#Function declaration -stop

display_inputbox "Display Filename" "Which file in the current directory do you want to display?" 15 30


if [ "`cat tmpfile.txt`" != "" ]; then
  cat "`cat tmpfile.txt`"
else
  echo "Nothing to do"
fi
