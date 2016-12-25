#!/bin/bash

done=0

while true ; do
clear 
printf "test1" | toilet -f term --gay | pv -qL 25
sleep 0.5 
printf "test2" | toilet -f term --gay | pv -qL 25
sleep 0.5
printf "test3" | toilet -f term --gay | pv -qL 25
sleep 0.5
printf 'today = %s\n' "$(date +%R\ %A\ %e\ %B\ %x)"  | toilet -f term | pv -qL 25    if [ something ]; then
        break
    fi
done
