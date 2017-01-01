#!/usr/bin/bash
hpny(){
clear
NY=('Happy ' 'New ' 'Year ')
for i in "$@"
do
printf '%s\n' "${i}" | figlet | toilet --irc -f term -d /usr/share/figlet/fonts/ --gay | pv -qL 250
done
}
hpny "$@"

