#!/bin/bash

######################################
#A typwriter that welcoms you        #
#and writes the current date notation#
#in the format that's been used      #
#                                    #
#PS: pv and toilet as dependencies   #
######################################

done=0
while true ; do
clear 
printf "Good day :)" | toilet -f term --gay | pv -qL 125
sleep 0.30
printf 'today = %s\n' "$(date +%R\ %A\ %e\ %B\ %x)"  | toilet -f term --gay | pv -qL 125
    if [ something ]; then
        break
    fi
done