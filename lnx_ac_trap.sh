#!/bin/bash
#Script to display the functionality of the traps

clear
trap 'echo "- Please Press Q to Exit.."' SIGINT SIGTERM SIGTSTP

while [ "$CHOICE" != "Q" ] && [ "$CHOICE" != 'q' ]; do
  echo "Simple Menu"
  echo "###########"
  echo "1) Choice 1"
  echo "2) Choice 2"
  echo "3) Choice 3"
  echo "q) Quit/Exit"
  read CHOICE
  clear
done
