#!/usr/bin/env bash
watchandrespond(){
options=('.test0' '.test1' '.test2')
path=/home/batch/scripts/testing/
array=('one' 'two' 'three')
for i in "${array[@]}"
do
while inotifywait -q -e modify "$path/$i/out" >/dev/null
do 
data=($(tail -n 1 "$path/$i/out"))
if [[ "${data[3]}" = ".options" ]] && [[ "${data[4]}" = "" && "${data[2]}" = "$i[@]" ]]
then
echo ${options[@]} > "$path/$i/in"
fi
done
done
}

