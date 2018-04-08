#!/bin/bash
# Print a message about disk useage.
space_free=$( df -h | awk '{ print $5 }' | sort -n | tail -n 1 | sed 's/%//' )
case $space_free in
     [1-25]*)
        echo Plenty of disk available
        ;;
     [26-50]*)
        echo There is enough disk space
	;;
    [51-75]*)
        echo There is less space
	;;
    [76-100]*)
        echo Emergency! have to extend filesystem or free filesystem
        ;;
           *)
             echo Something is not quite right here
             ;;
esac

