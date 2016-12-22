#!/usr/bin/bash
options=('.test0' '.test1' '.test2')
path=/home/"$LOGNAME"/scripts/testing/
array=('one' 'two' 'three')

watchandrespond(){
for i in "${array[@]}"
do
while inotifywait -q -e modify "/$i/out" >/dev/null
do 
data=($(tail -n 1 "$path/$i/out"))
if [[ "${data[3]}" = ".options" ]] && [[ "${data[4]}" = "" && "${data[2]}" = "$i[@]" ]]
then
echo "${options[@]}" > "$path/$i/in"
fi
done
done
}

