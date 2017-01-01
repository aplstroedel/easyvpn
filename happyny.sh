#!/usr/bin/env bash
hpny(){
for i in "$@"
do
printf '%s\n' "${i}" | figlet | toilet -f term -d /usr/share/figlet/fonts --irc --gay | pv -qL 250
done
}
hpny "$@"

