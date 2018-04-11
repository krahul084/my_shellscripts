#!/bin/bash
#Script to display the functionality of script paramereters
NAME=$1
read -p "Enter Your Age :" AGE

calculate_age_in_days() {
  echo "Hi $NAME your age in days is $(( $1 * 365 ))"
}

calculate_age_in_days $AGE
