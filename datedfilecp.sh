#!/bin/bash
#This is a dated file copy script

date=$("date +"%m-%d-%y"")
cp -rp $1 $date.$1
echo the file created is $date.$1
