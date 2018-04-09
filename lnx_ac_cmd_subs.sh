#!/bin/bash
#Script to display the command substitution

shopt -s expand_aliases
TODAYSDATE=`date`
USERFILES=$(sudo find /home -user user)
alias TODAY="date"
alias UFILES="find /home -user user"
A=`TODAY`
B=`UFILES`
echo "Todays date is $A"
echo "The User files are below\n:$B"
