#!/bin/bash

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