#!/bin/bash
#Script to test the day of week
day=$(date '+%a')
case $day in
  Mon)
	echo Monday
        ;;
  Tue)
        echo Tuesday
	;;
  Wed)
	echo Happy hump day 
	;;
  Thu)
	echo Thursday
	;;
  Fri)
	echo TGIF
	;;
  Sat)
	echo Saturday
	;;
  Sun)
	echo Sunday
	;;
  *)
	echo Error
	;;
esac
  

