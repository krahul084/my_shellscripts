#!/bin/bash
#Script to display the username,password,start and end time of script

MYUSERNAME='krahul'
MYPASSWORD='unique123'

STARTOFSCRIPT=$(date)

echo "Starttime of script is:$STARTOFSCRIPT"
echo "My username is :$MYUSERNAME, and my password set is :$MYPASSWORD"
ENDOFSCRIPT=`date`
echo "Endtime of script is:$ENDOFSCRIPT"
