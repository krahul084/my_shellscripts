#!/bin/bash
#Sample case statement script

case $1 in
  start)
    echo starting
    ;;
  stop)
    echo stopping
    ;;
  restart)
    echo restarting
    ;;
  *)
    echo dont know
    ;;
esac
