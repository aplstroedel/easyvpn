#!/usr/bin/bash

######################################
#   typwriterfun that welcoms you    #
#and writes the current date notation#
#   in the format that's been used   #
#                                    #
#ncat, pv and toilet as dependencies #
#                                    #
# automated netcat server = line 24  #
#    keeps listening until ctrl+c    #
#                                    #
#               USAGE:               #
#    path2=/your/directory/here      #
#                                    #
#        from remote machine:        #
#          ncat <ip> <port>          #
######################################

location='/$HOME'
path2='/git/testffs'			# <-- directory of this script


ncat -v -lk -p 6000 --send-only -c "source /$location/$path2/colorhellodate.sh; fun"

fun(){

while true ; do
clear 
printf "Good day :)" | toilet -f term --gay | pv -qL 125
sleep 0.30
printf 'today = %s\n' "$(date +%R\ %A\ %e\ %B\ %d-%m-%Y)"  | toilet -f term --gay | pv -qL 75
sleep 0.30
    if [ something ]; then
        break
    fi
done
}
