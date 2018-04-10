#!/bin/bash
#Script to display the functionality of if conditional
echo "Enter Your guess between 1-5"
read -p 'Guess:' guess

if [ $guess -eq 3 ]; then
  echo "You guess is correct!"
fi
