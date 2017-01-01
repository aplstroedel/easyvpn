#!/usr/bin/env bash
hpny(){
clear
for i in "$@"
do
printf '%s' "${i}" | figlet | toilet --irc --gay | pv -qL 250
done
}
hpny "$@"

