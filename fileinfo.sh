#!/bin/bash
#Script to display the file details like filename, size and owner information

read -p "Enter the filename" file1
echo Filename username size

ls -al $file1 |awk '//{print $9,$3,$5}'
