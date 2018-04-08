#!/bin/bash
#A simple bash script

cp $1 $2
list="ls -lh"
echo listing details for $2
$list $2
echo $#
echo $@
echo $?
echo $$
echo user:$USER is running on $HOSTNAME and it took $SECONDS:seconds and now this command is run in line number:$LINENO
