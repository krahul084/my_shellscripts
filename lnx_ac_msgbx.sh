#!/bin/bash
#Script to display the functionality of the message box
MSGBOX=${MSGBOX=dialog}
TITLE="Warning"
MESSAGE="Just diplaying some content to screen"
XCOORD=10
YCOORD=21


#FUNCTION Declaration-start
display_msgbox() {
  $MSGBOX --title "$1" --msgbox "$2" "$3" "$4"
  echo "Completed the operation"
}

#Function declaration- stop

if [ "$1" == "shutdown" ]; then
  display_msgbox "WARNING" "Do you want to shutdown ..." 10 21
  echo "Shutting down ..."
else
  display_msgbox "Confirmation" "Do you want to proceed further" 10 21
  /home/user/scripts/lnx_ac_infobox.sh
fi
