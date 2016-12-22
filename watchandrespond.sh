#!/usr/bin/bash
options=('.test0' '.test1' '.test2')
path=/home/"$LOGNAME"/scripts/testing/
array=('one' 'two' 'three')

watchandrespond(){
for i in "${array[@]}"
do
while inotifywait -q -e modify "$path/$i/out" >/dev/null
do 
data=($(tail -n 1 "$path/$i/out"))
if [[ "${data[1]}" = ".options" ]]
then
echo "${options[@]}" > "$path/$i/in"
fi
done
done
}
watchandrespond&
