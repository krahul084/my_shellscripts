#!/bin/bash
#Script to display the contents of the onformation box

#Global Variables
INFOBOX=${INFOBOX=dialog}
TITLE="Default"
MESSAGE="Something to say"
XCOORD=10
YCOORD=20

#Function Declarations- start
display_infobox() {
  $INFOBOX --title "$1" --infobox "$2" "$3" "$4"
  sleep "$5"
}

#Function Declarations- stop

if [ "$1" == "shutdown" ]; then
  display_infobox "WARNING" "Shutting the system in 5 seconds" 10 20 5
  echo "Shutting down now!"
else
  display_infobox "INFORMATION" "Just displaying the content in 4 secs" 10 20 4
  echo "This  is the content!"
fi


