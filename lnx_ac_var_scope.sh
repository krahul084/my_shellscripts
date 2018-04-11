#!/bin/bash
#Script to display the functionality of variable scope

GLOBAL=10
echo "Displaying the Local and Global variables inside the fucntion GLOBAL:$GLOBAL and LOCAL:$LOCAL"

func_var_scope(){
  LOCAL=5
  echo "Displaying the Local and Global variables inside the fucntion GLOBAL:$GLOBAL and LOCAL:$LOCAL"
}

func_var_scope
echo "Displaying the Local and Global variables inside the fucntion GLOBAL:$GLOBAL and LOCAL:$LOCAL"
