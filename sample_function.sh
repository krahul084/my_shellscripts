#!/bin/bash
#Sample script to display the functionality of a function

print_something () {
  echo Hello $1
  return 7
}
print_something Rahul
print_something test1
echo The previous function has a return value of $?
