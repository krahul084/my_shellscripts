#!/bin/bash
#to demonstrate variable scope

v1=bar
v2=go

#Lets verify current value
echo $0 :: v1: $v1, v2 : $v2

export v1
./sample3.sh

# Lets see what they are now
echo $0 :: v1: $v1, v2 : $v2
