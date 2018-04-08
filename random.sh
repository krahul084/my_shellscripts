#!/bin/bash
#Script to generate the random numbers between a and b
a=$(shuf -i $1-$2 -n 1)
echo The random number is $a

