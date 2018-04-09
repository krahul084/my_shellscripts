#!/bin/bash
#Script to explain exit status
a=$(( 1 + 4 ))
echo $?

#rm dool.sh >2&>1 /dev/null
rm dool.sh
echo $?

b=$(( 54 * 5 ))
echo $?
