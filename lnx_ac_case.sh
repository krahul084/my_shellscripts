#!/bin/bash
#Script to display the menu using the case statements

echo "SIMPLE MENU"
echo "Enter either : 1/2/3"
read -p 'Your Choice: ' choice

case $choice in 
  1)
    echo "Congrats for choosing 1st option"
    ;;
  2)
    echo "Congrats for choosing 2nd option"
    ;;
  3) 
    echo "Congrats for choosing 3rd option"
    ;;
  *)
    echo "You have entered invalid number"
    ;;
esac


