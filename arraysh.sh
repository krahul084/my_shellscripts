#!/bin/bash
#Simple script to loop over the array

myarray=("websrv1" "krahulsrv1" "websrv2" "websrv5")
COUNT=0

for index in ${myarray[@]}; do
  echo "Processing for server: ${myarray[COUNT]}"
  COUNT=$(( $COUNT + 1 ))
done
