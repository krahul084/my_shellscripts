#!/bin/bash

#Script to diaplay a menu
MENU=${MENU=dialog}

#Function declaration-start

display_menu() {
  $MENU --title "M A I N  M E N U" --menu "Please enter the choice from below options" 30 65 5  "1" "Install Docker" "2" "Install Nagios" "3" "Install Splunk" "4" "Install Jenkins" X "Exit" 2>choice.txt
}
#Function Declaration- stop
clear
display_menu
clear
case "`cat choice.txt`" in
  1) echo "Installed Docker";;
  2) echo "Installed Nagios";;
  3) echo "Installed Splunk";;
  4) echo "Installed Jenkins";;
  X) echo "We have quit the menu!"
esac

