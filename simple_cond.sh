#!/bin/bash
#Sample script to test the conditional statements in BASH
echo "Your Inputs $@ will be taken into consideration for the installation"
if [ $# -lt 2 ]; then
  echo "Wrong inputs! The proper usage of script is:"
  echo "$0 [yes/no] [age]"
  exit 4
fi
echo "Thank You for providing valid inputs!Your Request is processing!!!!"
if [ $1 == 'yes' ] && [ $2 -gt 18 ]; then
  echo "##" ; sleep 2
  echo "##" ; sleep 2
  echo "##" ; sleep 2
  sudo yum list installed |grep -i elinks
  check=$?
  if [ $check -eq 0 ]; then
    echo "The Package Elinks already installed!"
    sudo yum list installed |grep -i elinks
    exit 5
  elif [  $check -gt 0 ]; then
    sudo yum install -y elinks 2>&1 > /dev/null
      if [ $? -gt 0 ]; then
        echo "Install Failed, Please check the yum log for troubleshooting"
        exit 2
      fi
    sudo tail -1 /var/log/yum.log
    echo "Elinks has completed installation"
  fi
else
  echo "Installation not supported for you,Sorry!"
fi
